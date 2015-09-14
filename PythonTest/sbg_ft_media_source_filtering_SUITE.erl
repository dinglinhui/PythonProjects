            %%% #0. BASIC INFORMATION
%%% ---------------------------------------------------------------------
%%% %CCaseFile:sbg_ft_media_source_filtering_SUITE.erl %
%%% Author : etxjjkk 
%%% Purpose : Test suite template for running PTA from jpT
%%% Created : 2008-12-16
%%% ---------------------------------------------------------------------
%%% GenTS Header:
%%% ----------------------------------------------------------
%%% $Head_Prepared EAB/FLA/DT Ulf Nordstr�m
%%% $Head_DocNo    3/152 41-CSA 101 05+ Uen
%%% $Head_Approved EAB/FLA/DS Ilkka Koskinen
%%% $Head_Checked  
%%% $Head_Date     2009-12-11
%%% $Head_Rev      A
%%% $Head_File
%%% $End
%%% ----------------------------------------------------------
%%% $Title Media Source Filtering
%%% $End
%%% ----------------------------------------------------------

-module(sbg_ft_media_source_filtering_SUITE).
-date('2014-10-08').
-author('xdinlin').

-id('488/152 15-HSD 101 96/1 Ux').
-vsn('/main/r1a_dev/21').

%%% ---------------------------------------------------------------------
%%% %CCaseCopyrightBegin%
%%% Copyright (c) Ericsson AB 2009-2014 All rights reserved.
%%% 
%%% The information in this document is the property of Ericsson.
%%% 
%%% Except as specifically authorized in writing by Ericsson, the 
%%% receiver of this document shall keep the information contained 
%%% herein confidential and shall protect the same in whole or in 
%%% part from disclosure and dissemination to third parties.
%%% 
%%% Disclosure and disseminations to the receivers employees shall 
%%% only be made on a strict need to know basis.
%%% %CCaseCopyrightEnd%
%%%
%%%
%%% ----------------------------------------------------------
%%% #1. REVISION LOG
%%% ----------------------------------------------------------
%%% Rev       Date      Name       What
%%% -----------------------------------------------------------------------
%%% R1A/1-2   140916    xdinlin    First version
%%% R1A/3     140918    xjiasha    Added the testcase sbg_msf_001
%%% R1A/4     140919    xjiasha    Added the testcase sbg_msf_002,sbg_msf_003
%%% R1A/5     140922    xjiasha    Added the testcase sbg_msf_004
%%% R1A/6     140922    xduacha    Updated new structure for test cases
%%% R1A/7     140924    xxianwu    Added the testcase sbg_msf_005
%%% R1A/8     140925    xdinlin    Implement function configure_netconf_with_entry and add method key/update_path_ids
%%% R1A/9     140925    xjiasha    Added the testcase sbg_msf_008
%%% R1A/10    140925    xdinlin    Modified code format
%%% R1A/11    140925    xdinlin    Added Revision log
%%% R1A/12    140925    xdinlin    Implement function check_result
%%% R1A/13    140925    xduacha    Updated traffic runnning functions
%%% R1A/14    140925    xduacha    Updated netconf configration functions
%%% R1A/15    140926    xjiasha    Added function sig_mo_info/4
%%% R1A/16    140926    xdinlin    Added macro TCID
%%% R1A/17    140926    xduacha    Updated test cases for new structure
%%% R1A/18    140929    xdinlin    Added the testcase sbg_msf_018 and sbg_msf_019
%%% R1A/19    140930    xdinlin    Added the testcase sbg_msf_020, Modified Comments and Reduced all cases's timeout num. 
%%% R1A/20    140930    xxianwu    Added test case sbg_msf_006 and sbg_msf_007
%%% R1A/21    141008    xdinlin    Added test case sbg_msf_012
%%% -----------------------------------------------------------------------
%%%
%%% ----------------------------------------------------------
%%% #2. EXPORT INCLUDES AND DEFINES
%%% ----------------------------------------------------------
-compile(export_all).

-include("/vobs/ims/sbg/ft/lib/sbg_test_support/include/sbg_ft_data_model.hrl").

-define(FTS, "sbg_ft_media_source_filtering_SUITE.erl").

-define(PT_TEST_SUITE_TO_LOAD_PCSCF_ACCESS, ["sbg_ft_media_source_filtering_access.ptts"]).

-define(PT_TEST_SUITE_TO_LOAD_PCSCF_CORE, ["sbg_ft_media_source_filtering_core.ptts"]).

-define(PT_TEST_SUITE_TO_LOAD_PCSCF_BGF, ["sbg_ft_media_source_filtering_bgf.ptts"]).

-define(PT_TEST_SUITE_BGF_PARAMS, [{site_id, "no_SiteId"}]).

-define(DUMMY_FUNCTION, fun() -> ok end).

-define(TCID, begin
          {_, {_M,F,_A}} =
              erlang:process_info(self(), current_function),
              erlang:atom_to_list(F)
              end).

%%% ----------------------------------------------------------
%%% #3. TEST SERVER CALLBACKS
%%% ----------------------------------------------------------

%%% ----------------------------------------------------------------------------
%%% suite/0
%%%
%%% Arguments:   -
%%%
%%% Description:
%%%
%%% Return:      Empty list []
%%% ----------------------------------------------------------------------------
suite() ->
    [].

%%% ----------------------------------------------------------------------------
%%% init_per_suite/
%%%
%%% Input: Config - Tuple list holding the test case configuration.
%%%   
%%% Descr: Initiation before the whole suite.
%%%
%%%        1) Additional paths is set according to JPT.
%%%        2) agsaDonny = DNS simulator, will only be used in simulated env
%%%           and is started for IPV4.
%%%        3) Any given configurable values are Initiated.
%%%
%%% ----------------------------------------------------------------------------
init_per_suite(Config) ->
    sbgFtSupport:init_per_suite(Config).

%%% ----------------------------------------------------------------------------
%%% end_per_suite
%%% 
%%% Input: Config - Tuple list holding the test case configuration.
%%%  
%%% Descr: Cleanup after the whole suite.
%%% ----------------------------------------------------------------------------
end_per_suite(Config) ->
    sbgFtSupport:end_per_suite(Config).

%%% ----------------------------------------------------------------------------
%%% init_per_testcase/2
%%%
%%% Input: TestCase - Name of the test case that is about to be run.
%%%        Config   - Tuple list holding the test case configuration.
%%%
%%% Descr: Initiation before each test case.
%%%
%%%        1) PTA Instances are started
%%%        2) Initiation is done according to given configuration
%%%
%%% ----------------------------------------------------------------------------
init_per_testcase(TestCase, Config) ->
    sbgFtSupport:init_per_testcase(TestCase, Config).

%%% ----------------------------------------------------------------------------
%%% end_per_testcase
%%%
%%% Input: TestCase - Name of the test case that is about to be run.
%%%        Config   - Tuple list holding the test case configuration.
%%%
%%% Descr: Cleanup after each test case.
%%% ----------------------------------------------------------------------------
end_per_testcase(TestCase, Config) ->   
    sbgFtSupport:end_per_testcase(TestCase, Config).

%%% ----------------------------------------------------------------------------
%%% init_per_group/2
%%%
%%% Arguments:   GroupName - Group Name
%%%              Config    - Proplist, used by JPT and Common Test
%%%
%%% Description: Run once per group
%%%
%%% Return:      Config - Proplist, used by JPT and Common Test
%%% ----------------------------------------------------------------------------
init_per_group(Group, Config) ->
    GroupInfoList = [list_to_atom(X) || X <- string:tokens(atom_to_list(Group), "_")],
    Role = pickup_avail_item_from_list([aalg, ibcf, pcscf], GroupInfoList),
    Ipvsn = pickup_avail_item_from_list([ipv4, ipv6, both], GroupInfoList),
    case lists:member(undefined, [Role, Ipvsn]) of
        true ->
            attach_group_comment(Group),
            Config;
        false ->
            ScenarioFlag = pickup_avail_item_from_list(['2pl','4pl'], GroupInfoList),
            Scenario = scenario(ScenarioFlag),
            ExtBgf = lists:member(bgf, GroupInfoList),
            case lists:member({role_loaded, true}, Config) of
                true -> ok;
                _ -> configure_and_load_suites(Scenario, Role, Ipvsn, ExtBgf)
            end,
            attach_group_comment(Role, Ipvsn, ExtBgf),
            Config ++ [{scenario, Scenario}, {role, Role}, {ip_version, Ipvsn}, {ext_bgf, ExtBgf}, {sctp, ExtBgf}, {role_loaded, true}] 
    end.

%%% ----------------------------------------------------------------------------
%%% end_per_group/2
%%%
%%% Arguments:   GroupName - Group Name
%%%              Config    - Proplist, used by JPT and Common Test
%%%
%%% Description: Run once per group
%%%
%%% Return:      {return_group_result, ok}
%%% ----------------------------------------------------------------------------
end_per_group(Group, Config)->
    sbgFtSupport:end_per_group(Config),
    ct:comment("Group ~p finished", [Group]),
    {return_group_result, ok}.

%%% ----------------------------------------------------------------------------
%%% all/0
%%%
%%% Input: List of testcase names/functions (atoms).
%%% 
%%% Descr: Returns a list of the test cases the LSV team will run.
%%% ----------------------------------------------------------------------------
all() ->
    [{group, ffv}]. 
%%     
%%% ----------------------------------------------------------------------------
%%% groups/0
%%%
%%% Arguments:   -
%%%
%%% Description: Definition of all groups of testcases and subgroups.
%%%
%%% Return:      Proplist of all groups
%%% ----------------------------------------------------------------------------
groups()->
    sbgFtSupport:groups(
        selection_names(), fun selection_testcases/1,
        prerequisite_names(), fun testcase_prerequisites/1,
        fun group_exec_properties/2
        ).

%%% ----------------------------------------------------------------------------
%%% selection_names/0
%%%
%%% Arguments:   -
%%%
%%% Description: Defines available test case selection groups.
%%%              
%%%              These are top level groups that can be invoked using, e.g.:
%%%              > jpt ... -group mfv
%%%
%%%              The purpose is to limit execution to a subset of testcases.
%%%              For each selection group, the function selection_testcases/1
%%%              defines which test cases are part of it.
%%%
%%% Return:      [atom()]   List of selection group names
%%% ----------------------------------------------------------------------------

selection_names() ->
    [ffv, nat, no_nat].

selection_testcases(ffv) -> % Full functional verification
    %% Complete contents of all chapters
    lists:append(
        [
            selection_testcases(nat),
            selection_testcases(no_nat)
            ]);    

selection_testcases(nat) ->
    [
        sbg_msf_008,
        sbg_msf_009,
        sbg_msf_015,
        sbg_msf_016,
        sbg_msf_017,
        sbg_msf_017a,
        sbg_msf_019
        ];

selection_testcases(no_nat) ->
    [
        sbg_msf_001,
        sbg_msf_002,
        sbg_msf_003,
        sbg_msf_004,
        sbg_msf_005,
        sbg_msf_006,
        sbg_msf_007,
        sbg_msf_010,
        sbg_msf_011,
        sbg_msf_012,
        sbg_msf_013,
        sbg_msf_014,
        sbg_msf_018,
        sbg_msf_020
        ].

%%% ----------------------------------------------------------------------------
%%% prerequisite_names/0
%%%
%%% Arguments:   -
%%%
%%% Description: Defines available prerequisite groups. These are subgroups
%%%              that can form a hierarchy. They are used to group test cases
%%%              that require the same configuration so that the configuration
%%%              does not have to be reset for each test case.
%%%
%%%              Each prerequisite group should have a corresponding clause in
%%%              init_per_group/2 that performs the necessary configuration
%%%              changes, and a corresponding clause in end_per_group/2 that
%%%              reverts those changes.
%%%
%%%              The function testcase_prerequisistes/1 defines what test
%%%              prerequisite group(s) that each test case belongs to.
%%%
%%% Return:      [atom()]   List of prerequisite group names
%%% ----------------------------------------------------------------------------
prerequisite_names() ->
    [pcscf_ipv4_bgf].

%%% ----------------------------------------------------------------------------
%%% testcase_prerequisites/1
%%%
%%% Arguments:   atom()  Test case name
%%%
%%% Description: Defines prerequisites of each test case.
%%%
%%%              The prerequisites are specified as an ordered list of
%%%              prerequisite names (see prerequisite_names/0). The list
%%%              represents a path in the hierarchy of prerequisite groups to
%%%              the one that the testcase belongs to.
%%%
%%%              Returning [foo, bar] for a test case x means that x is part of
%%%              the subgroup bar under the foo (which in turn is part of some
%%%              top level selection group(s)). Thus, init_per_group/2 will be
%%%              run for foo and bar before executing x (and any other test
%%%              case with a prerequisites list that starts with [foo, bar]). 
%%%
%%%              You may limit invocation to a specific prerequisite group
%%%              under a specific selection group using, e.g.:
%%%              > jpt ... -group '[ffv, pcscf_ext_bgf_ipv4]'
%%%
%%% Return:      [atom()]   Ordered list of prerequisite names
%%%
%%% Example:
%%%   test_case_prerequisites(tc_123) -> [pcscf_ipv4, ext_bgf, srtp_allowed]
%%% ----------------------------------------------------------------------------

testcase_prerequisites(_Testcase) -> 
    % only one requirement group for all the cases.
    [pcscf_ipv4_bgf].
%% TODO: delete mapping code below
%% case Testcase of
%%         % Configuration tests, no pre-setup.
%%      sbg_msf_001     -> [pcscf_ipv4_udp];
%%      sbg_msf_002     -> [pcscf_ipv4_udp];
%%      sbg_msf_003     -> [pcscf_ipv4_udp];
%%      sbg_msf_004     -> [pcscf_ipv4_udp];
%%      sbg_msf_005     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_006     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_007     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_008     -> [pcscf_ipv4_udp];
%%      sbg_msf_009     -> [pcscf_ipv4_udp];
%%      sbg_msf_010     -> [pcscf_ipv4_tcp_active];
%%      sbg_msf_011     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_012     -> [pcscf_ipv4_tcp_active];
%%      sbg_msf_013     -> [pcscf_ipv4_tcp_active];
%%      sbg_msf_014     -> [pcscf_ipv4_tcp_active];
%%      sbg_msf_015     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_016     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_017     -> [pcscf_ipv4_udp];
%%      sbg_msf_017     -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_017a    -> [pcscf_ipv4_udp];
%%      sbg_msf_017a    -> [pcscf_ipv4_tcp_passive];
%%      sbg_msf_018     -> [pcscf_ipv4_udp];
%%      sbg_msf_019     -> [pcscf_ipv4_udp];
%%      sbg_msf_020     -> [pcscf_ipv4_udp]
%%     end.

%%% ----------------------------------------------------------------------------
%%% group_exec_properties/1
%%%
%%% Arguments:   atom()   Selection group name
%%%              [atom()] Path of prerequisite names
%%%
%%% Description: Defines group execution properties for a group specified using
%%%              the top level selection group, and the path to the prerequisite
%%%              subgroup.
%%%
%%% Return:      Properties -- see Common Test documentaiton
%%%
%%% Example:
%%%   group_exec_properties(ffv, [pcscf_ipv4, ext_bgf]) -> [shuffle]
%%% ----------------------------------------------------------------------------

group_exec_properties(_SelectionName, _PrerequisitePath) ->
    [].

%%% ---------------------------------------------------------- 
%%% #4. INTERNAL FUNCTION DEFINITIONS
%%% ----------------------------------------------------------

%%% ----------------------------------------------------------------------------
%%% run_test_case_with_conf_list/4
%%%
%%% Arguments:    TestCaseId - string(), Test case Id
%%%               Header - string(), a brief of test case
%%%               ConfigList - Proplist, Running configuration from jpT environment
%%%                   which contains Role, Ipvsn, ExtBgf and Segall information
%%%               SettingList - Proplist, list of configurations
%%%
%%% Description:  Run test case
%%%
%%% Return:       ok | {error, Reason}
%%% ----------------------------------------------------------------------------
run_test_case_with_conf_list(TestCaseId, Header, ConfigList, SettingList) ->
    run_test_case_with_conf_list(TestCaseId, Header, ConfigList, SettingList, ?DUMMY_FUNCTION).

run_test_case_with_conf_list(TestCaseId, Header, ConfigList, SettingList, Fallback) ->
    ct:comment("Test Case Header: ~p~n",[Header]),

    PostConfigList = pre_config_with_conf_list(SettingList),
    Result = run_test_case(TestCaseId, ConfigList),
    ok = post_config_with_conf_list(PostConfigList),

    check_result(Result, Fallback).

%%% ----------------------------------------------------------------------------
%%% pre_config_with_conf_list/1
%%%
%%% Arguments:    SettingList - PorpList
%%%
%%% Description:  Pre configure by SettingEntryList, if any error, post config
%%%                   and then fail the testcase. 
%%%
%%% Return:       DeSettingList
%%% ----------------------------------------------------------------------------
pre_config_with_conf_list(SettingList) ->
    pre_config_with_conf_list(SettingList, []).

pre_config_with_conf_list([], DeSettingList) ->
    DeSettingList;

pre_config_with_conf_list([H|T], DeSettingList) ->
    DeSettingEntry = try
        DeSettingEntry0 = generate_de_setting_entry(H),
        ok = configure_netconf_with_entry(H),
        DeSettingEntry0
    catch
        Error:Reason ->
            ct:pal("Pre-config failed when configuring with entry: ~p. (Error info:~p ~p)~n", [H, Error, Reason]),
            ok = post_config_with_conf_list(DeSettingList),
            ct:pal("Failed the test case.~n"),
            ct:fail(Error)
    end,
    pre_config_with_conf_list(T, [DeSettingEntry|DeSettingList]).

%%% ----------------------------------------------------------------------------
%%% post_config_with_conf_list/1
%%%
%%% Arguments:    SettingEntryList - PorpList
%%%
%%% Description:  Post configure by SettingEntryList, if any error, fail the 
%%%                   testcase.
%%%
%%% Return:       ok
%%% ----------------------------------------------------------------------------
post_config_with_conf_list([]) ->
    ok;

post_config_with_conf_list([H|T]) ->
    try
        ok = configure_netconf_with_entry(H)
    catch
        Error:Reason ->
            ct:pal("Post-config failed when configuring with entry: ~p. (Error info:~p)~n", [H, Error, Reason]),
            ct:pal("Terrible issue, failed the test case now.~n"),
            ct:fail(Error)
    end,
    post_config_with_conf_list(T).


%%% ----------------------------------------------------------------------------
%%% generate_de_setting_entry/1
%%%
%%% Arguments:    SettingEntry - {MoInfo, UpdatedAttr, Action}
%%%
%%% Description:  Generate DeSetting Entry By SettingEntry
%%%
%%% Return:       DeSettingEntry
%%% ----------------------------------------------------------------------------
generate_de_setting_entry({MoInfo, UpdatedAttr, create}) ->
    {MoInfo, UpdatedAttr, delete};

generate_de_setting_entry({MoInfo, UpdatedAttr, merge}) ->
    OringinAttr = get_current_attributes(MoInfo, UpdatedAttr),
    {MoInfo, OringinAttr, merge}.


%%% ----------------------------------------------------------------------------
%%% get_current_attributes/1
%%%
%%% Arguments:   MoInfo = {MoName, MoId}                e.g. MoName("AccessNetPcscf"), MoId("1")/("[1,2,3]")/null
%%%              UpdatedAttr                            Update Attributes, e.g. [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS"]}]
%%%
%%% Description: get original netconf attrubutes for input params
%%%
%%% Return:      Attributes, e.g. [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS"]}] or {nok,ErroeMessage}
%%% Example:     get_oringinal_attributes({{"AccessNetPcscf",1},[{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS"]}]})=
%%%              [{mediaSourceFilteringWithoutNAT,["SDP_IP_ADDRESS_AND_PORT"]}]
%%% ---------------------------------------------------------------------------- 

get_current_attributes(MoInfo, UpdatedAttr) ->
    [Response] = sbgFtGenNetconfSupport:get(key(MoInfo)),
    CurrentAttrs = get_mo_attrs_from_path(list_to_atom(mo_name(MoInfo)), Response),
    change_value_to_list(UpdatedAttr, CurrentAttrs).

mo_name({MoInfo, _Attrs}) ->
    MoInfo;

mo_name(MoName) ->
    MoName.

get_mo_attrs_from_path(MoName, {MoName, Attrs}) ->
    Attrs;

get_mo_attrs_from_path(MoName, {_OtherName, [{id, _IdValue}, Attrs]}) ->
    get_mo_attrs_from_path(MoName, Attrs).

change_value_to_list(UpdatedAttr, OringinAttr) ->
    KeySelect = proplists:get_keys(UpdatedAttr),
    [{Key, Value} || {Key, Value} <- OringinAttr, lists:member(Key, KeySelect)].

%%% ----------------------------------------------------------------------------
%%% configure_netconf_with_entry/1
%%%
%%% Arguments:   MoInfo = {MoName, MoId}    e.g. MoName("AccessNetPcscf"), MoId("1")/("[1,2,3]")/null
%%%              UpdatedAttr                Update Attributes, e.g. [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS"]}]
%%%              Action                     e.g. create/merge/delete
%%%
%%% Description: Netconf config method, include create/merge/delete method.
%%%
%%% Return:     ok - success.
%%%             {nok,ErrorMessage} - unsuccess, return ErrorMessage for reason.
%%%
%%% Example:    configure_netconf_with_entry({{"AccessNetPcscf", 1}, [{mediaSourceFilteringWithoutNAT,["SDP_IP_ADDRESS_AND_PORT"]}], merge})
%%%   
%%% ----------------------------------------------------------------------------     
configure_netconf_with_entry({MoInfo, UpdatedAttr, Action}) ->
    do_configure_netconf_with_entry(MoInfo, UpdatedAttr, Action).

%%% ----------------------------------------------------------------------------
do_configure_netconf_with_entry(MoInfo, UpdatedAttr, _Action = create) ->
    sbgFtGenNetconfSupport:create(key(MoInfo), UpdatedAttr);

do_configure_netconf_with_entry(MoInfo, UpdatedAttr, merge) ->
    SegFunc = fun({Key, Value}, {ListToModify, ListToDelete}) ->
        case Value of
            [""] ->
                {ListToModify, [Key|ListToDelete]};
             _ ->
                {[{Key, Value}|ListToModify], ListToDelete}
            end
    end,
    {ListToModify, ListToDelete} = lists:foldr(SegFunc, {[], []}, UpdatedAttr),
    Key = key(MoInfo),
    ok = sbgFtGenNetconfSupport:merge(Key, ListToModify),
    ok = sbgFtGenNetconfSupport:delete_attributes(Key, ListToDelete);


do_configure_netconf_with_entry(MoInfo, _UpdatedAttr, delete) ->
    sbgFtGenNetconfSupport:delete(key(MoInfo)).

%%% ----------------------------------------------------------------------------
%%% key/1
%%%
%%% Arguments:   MoName     e.g. MoName("AccessNetPcscf")
%%%              IdStack    e.g. [1,2,1]
%%%              LeafId     e.g. 1
%%%
%%% Description: get moName's path and format path to sbgFtGenNetconfSupport's need. 
%%%
%%% Return:      see below Example.
%%%
%%% Example:    key("SipPa") : "PCSCF:id=1.AccessNetPcscf:id=1.SipPa:id=1"
%%%             key({"SipPa", 1}) : "PCSCF:id=1.AccessNetPcscf:id=1.SipPa:id=1"
%%%             key({"SipPa", [1,1,1]}) : "PCSCF:id=1.AccessNetPcscf:id=1.SipPa:id=1"
%%%
%%% ----------------------------------------------------------------------------     
key({MoName, IdStack}) when is_list(IdStack)->
    Path = sbgFtGenNetconfSupport:get_path_and_attributes(MoName),
    UpdatedPath = update_path_ids(Path, IdStack),
    sbgFtGenNetconfSupport:create_netconf_key(UpdatedPath);

key({MoName, LeafId}) when is_integer(LeafId) ->
    ObjPath = sbgFtGenNetconfSupport:get_path(MoName),
    ObjKey = sbgFtGenNetconfSupport:create_netconf_key(ObjPath),
    lists:concat([ObjKey, ":id=", LeafId]);

key(MoName) ->
    Path = sbgFtGenNetconfSupport:get_path_and_attributes(MoName),
    sbgFtGenNetconfSupport:create_netconf_key(Path).

%%% ----------------------------------------------------------------------------
%%% update_path_ids/2
%%%
%%% Arguments:   Path    e.g. "PCSCF:id=1.AccessNetPcscf:id=1.SipPa:id=1", MoName's path and include attributes.
%%%              IdStack e.g. [2,1,2], Stack include ids that need to modify id where in path's different level.
%%%             
%%% Description: Recursion Path and IdStack two lists, and replace path's ids with IdStack.
%%%
%%% Return:      see below Example.
%%%
%%% Example:     update_path_ids("PCSCF:id=1.AccessNetPcscf:id=1.SipPa:id=1", [2,1,2]) -> "PCSCF:id=2.AccessNetPcscf:id=1.SipPa:id=2"
%%%   
%%% ----------------------------------------------------------------------------
update_path_ids([], _) ->
    [];

update_path_ids([{MoName, DefAttrList}|T], [IdH|IdT]) ->
    UpdatedAttrList = sbgFtGenNetconfSupport:change_value_in_struct(DefAttrList, [{id, [integer_to_list(IdH)]}]),
    [{MoName, UpdatedAttrList}|update_path_ids(T, IdT)].

%%% ----------------------------------------------------------------------------
check_result(Result, Fallback) ->
    try
        sbgFtSupport:run_check_result(Result)
    catch
        _Class:_Reason -> 
            Fallback(),
            ct:fail("Result: ~p~n", [Result])
    end.

%%% ----------------------------------------------------------------------------
%%% ----------------------------------------------------------------------------
%%% run_test_case/2
%%%
%%% Arguments:    TestCaseId - string(), Test case Id
%%%               ConfigList - Proplist , Running configuration from jpT environment
%%%                   which contains Role, Ipvsn, ExtBgf and Extra information
%%%
%%% Description:  Run test case
%%%
%%% Return:       ok | {error, Reason}
%%% ----------------------------------------------------------------------------
run_test_case(TestCaseId, ConfigList) ->
    BaseSetting = base_properties(ConfigList, all),
    ExtraSettings = extra_properties(ConfigList),

    do_run_test_case(TestCaseId, BaseSetting, ExtraSettings).

%%% ----------------------------------------------------------------------------
%%% do_run_test_case/3
%%%
%%% Arguments:    TestCaseId - string(), Test case Id
%%%               Setting - {Scenario, Role, Ipvsn, MatedPairs, ExtBgf}
%%%               ExtraSettings - Proplist
%%%
%%% Description:  Run test case
%%%
%%% Return:       Proplist - Check Result: 
%%% ----------------------------------------------------------------------------
do_run_test_case(TestCaseId, _BaseSetting = {Scenario, Role, Ipvsn, MatedPairs, ExtBgf}, ExtraSettings) ->
    ct:pal("Scenario: ~p, Role: ~p, Ip Version: ~p, With ExtBgf: ~p.~n", [Scenario, Role, Ipvsn, ExtBgf]),
    
    TestSuites = test_suites(Role, Ipvsn, MatedPairs, ExtBgf),

    ExtraInfo = extra_pre_config(ExtraSettings, Scenario, Role, Ipvsn),
    PtaResult = start_pta(TestCaseId, TestSuites),
    ExtraResult = extra_check_result(ExtraInfo),
    extra_post_config(ExtraSettings, Scenario, Role, Ipvsn),

    PtaResult ++ ExtraResult.

%%% ----------------------------------------------------------------------------
%%% extra_pre_config/4
%%%
%%% Arguments:    ExtraConfigurationList - list(), extra configuration
%%%               Scenario - atom()
%%%               Role - atom()
%%%               Ipvsn - atom()
%%%
%%% Description:  Do Extra Rollback, such as Seagull Stop.
%%%
%%% Return:       ok | {error, Reason}
%%% ----------------------------------------------------------------------------
extra_pre_config([], _Scenario, _Role, _Ipvsn) ->
    [].

%%% ----------------------------------------------------------------------------
%%% extra_check_result/1
%%%
%%% Arguments:    ExtraPreConfigResult - list(), 
%%%                   extra Preconfig result from extra_pre_config/4
%%%
%%% Description:  Do Extra Check,
%%%                   such as Seagull Log Compare, Counter Values compare.
%%%
%%% Return:       Proplist - Extra Check Result
%%% ----------------------------------------------------------------------------
extra_check_result([]) ->
    [].

%%% ----------------------------------------------------------------------------
%%% extra_post_config/4
%%%
%%% Arguments:    ExtraConfigurationList - list(), extra configuration
%%%               Scenario - atom()
%%%               Role - atom()
%%%               Ipvsn - atom()
%%%
%%% Description:  Do Extra Post Config, such as Seagull Stop.
%%%
%%% Return:       ok
%%% ----------------------------------------------------------------------------
extra_post_config([], _Scenario, _Role, _Ipvsn) ->
    ok.

%%% ----------------------------------------------------------------------------
%%% sig_mo_info/4
%%%
%%% Arguments:    Scenario
%%%               pcscf
%%%               access | core
%%%
%%% Description:  Find MoName & MoId
%%%
%%% Return:       {MoName, MoId}
%%% ----------------------------------------------------------------------------
sig_mo_info(Scenario, pcscf, access, Ipvsn)->
    {?PcscfAccessSigNetObjName, sig_mo_id(Scenario, pcscf, access, Ipvsn)}.

sig_mo_id(Scenario, Role, _Type, Ipvsn)->
    TypeInetV = list_to_atom(atom_to_list(access) ++ "_" ++  atom_to_list(Ipvsn)),
    jpTconfig:get_config({sbg_ft_configuration, sig_netw_conn, Scenario, Role, TypeInetV, id}).
    
%%% ----------------------------------------------------------------------------
%%% scenario/1
%%%
%%% Arguments:    Sign - atom(), 2pl | 4pl| undefined
%%%
%%% Description:  Translate scenario
%%%
%%% Return:       atom(), default is sbg_cba_2pl
%%% ----------------------------------------------------------------------------
scenario('2pl') ->
    sbg_cba_2pl;
scenario('4pl') ->
    sbg_cba_4pl;
scenario(_) ->
    sbg_cba_2pl.

%%% ----------------------------------------------------------------------------
%%% instances/5
%%%
%%% Arguments:    Role - atom(), pcscf | aalg 
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%               MatedPairs - list(), [1,2...]
%%%               PttsFile - string()
%%%               Parameters - Proplist
%%%
%%% Description:  Determine Instances Config to load by params
%%%
%%% Return:       Proplist, Instances Config
%%% ----------------------------------------------------------------------------
instances(Role, Ipvsn, MatedPairs, PttsFile) ->
    [[{role, Role}, {ip_version, Ipvsn}, {mated_pair, X}, {ptts_tc, PttsFile}] || X <- MatedPairs].

instances(Role, Ipvsn, MatedPairs, PttsFile, Parameters) ->
    [X ++ [{ptts_params, Parameters}] || X <- instances(Role, Ipvsn, MatedPairs, PttsFile)].


%%% ----------------------------------------------------------------------------
%%% test_suites/4
%%%
%%% Arguments:    Scenario - atom(), sbg_cba_2pl | sbg_cba_4pl
%%%               Role - atom(), pcscf | aalg 
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%               ExtBgf - boolean() | undefined
%%%
%%% Description:  Determine TestSuites Config to load Config by params
%%%
%%% Return:       Proplist - TestSuites Config
%%% ----------------------------------------------------------------------------
test_suites(sbg_cba_4pl, Role, Ipvsn, ExtBgf) ->
    test_suites(Role, Ipvsn, [1,2], ExtBgf);

test_suites(sbg_cba_2pl, Role, Ipvsn, ExtBgf) ->
    test_suites(Role, Ipvsn, [1], ExtBgf);

test_suites(Role, Ipvsn, MatedPairs, _ExtBgf = true) -> %% Added bfg instance when there is ExtBfg.
    [{bgf, instances(Role, Ipvsn, MatedPairs, ?PT_TEST_SUITE_TO_LOAD_PCSCF_BGF, ?PT_TEST_SUITE_BGF_PARAMS)}]
    ++ test_suites(Role, Ipvsn, MatedPairs, false);

test_suites(_Role = pcscf, Ipvsn, MatedPairs, _ExtBgf) -> %% Added acc&core instances for pcscf role.
    [{core, instances(pcscf, Ipvsn, MatedPairs, ?PT_TEST_SUITE_TO_LOAD_PCSCF_CORE)},
     {access, instances(pcscf, Ipvsn, MatedPairs, ?PT_TEST_SUITE_TO_LOAD_PCSCF_ACCESS)}].

%%% ----------------------------------------------------------------------------
%%% dns_conf/2
%%%
%%% Arguments:    Role - atom(), pcscf | aalg 
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%
%%% Description:  Determine Dns Config to load by Role and Ipvsn
%%%
%%% Return:       Proplist - Dns Config
%%% ----------------------------------------------------------------------------
dns_conf(_Role = pcscf, ipv6) -> %% TODO: now hard code ipv6 -> both due to bgf issue
    [{dns_type, default}, {acc_for_ip_version, both}, {core_ip_version, both}];
dns_conf(_Role = pcscf, Ipvsn) -> %% Specified the same ipvsn to acc&core sides for pcscf role
    [{dns_type, default}, {acc_for_ip_version, Ipvsn}, {core_ip_version, Ipvsn}].

%%% ----------------------------------------------------------------------------
%%% base_conf/2
%%%
%%% Arguments:    Scenario - atom(), sbg_cba_2pl
%%%               Role - atom(), pcscf | aalg
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%               ExtBgf - boolean()
%%%
%%% Description:  Determine Base Config to load by params
%%%
%%% Return:       Proplist - Base Config
%%% ----------------------------------------------------------------------------
base_conf(Scenario, _Role = pcscf, Ipvsn, ExtBgf) -> 
    %%StrIpvsn = atom_to_list(Ipvsn), %% Specified the same ipvsn to acc&core for pcscf role
    StrIpvsn = case Ipvsn of %% TODO: now hard code ipv6 -> both due to bgf issue
        ipv6 -> "both";
        _ -> atom_to_list(Ipvsn)
    end,
    SgcIpvsn = list_to_atom(StrIpvsn ++ "_" ++ StrIpvsn),
    [{scenario, Scenario}, {role, pcscf}, {sgc, SgcIpvsn}, {ext_bgf, ExtBgf}].

base_conf(_Group) -> %% oam
    base_conf(scenario(default), pcscf, ipv4, false).

%%% ----------------------------------------------------------------------------
%%% pickup_avail_item_from_list/2
%%%
%%% Arguments:    AvailItems - list::atom(), avail items
%%%               List - list::atom(), real items
%%% 
%%% Description:  Pickup the first avail item which in real list
%%%
%%% Return:       atom(), none | AvailItem
%%% ----------------------------------------------------------------------------
pickup_avail_item_from_list(_AvailItems, _List = []) ->
    undefined;
pickup_avail_item_from_list(AvailItems, _List = [H|T]) ->
    case lists:member(H, AvailItems) of
        true -> H;
        _ -> pickup_avail_item_from_list(AvailItems, T)
    end.

%%% ----------------------------------------------------------------------------
%%% configure_and_load_suites/1
%%%
%%% Arguments:    Scenario - sbg_cba_2pl
%%%               Role - atom(), pcscf | aalg
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%               ExtBgf - boolean()
%%%
%%% Description:  Configure base config and dns config &
%%%               Load test suites by params
%%%
%%% Return:       ok
%%% ----------------------------------------------------------------------------
configure_and_load_suites(Scenario, Role, Ipvsn, ExtBgf) ->
    Conf = base_conf(Scenario, Role, Ipvsn, ExtBgf),
    ConfDns = dns_conf(Role, Ipvsn),
    TestSuites = test_suites(Scenario, Role, Ipvsn, ExtBgf),
    ct:pal("Scenario:~n~p~nLoading test suites:~n~p~n", [Scenario, TestSuites]),
    Configure = fun() ->
            sbgFtSupport:reset_config(Conf),
            sbgFtSupport:reload_dns(ConfDns)
    end,
    Load = fun() ->
            sbgFtSupport:load_suites(TestSuites)
    end,
    ok = sbgFtSupport:config_and_load(Configure, Load).

%%% ----------------------------------------------------------------------------
%%% start_pta/2
%%%
%%% Arguments:   TestCaseId - string()
%%%              TestSuites - PropList
%%%
%%% Description: Start pta, run traffic with ptts
%%%
%%% Return:      list(), Results
%%% ----------------------------------------------------------------------------
start_pta(TestCaseId, TestSuites) ->
    %%% --- Start PTA Instances ---
    StartResult  = sbgFtSupport:start_pta_test_case(TestCaseId, TestSuites),
    ct:pal("StartResult: ~p~n",[StartResult]),

    %%% --- Get PTA Instances Result ---
    PtaResultList = sbgFtSupport:pta_test_case_result(TestCaseId, TestSuites),
    ct:pal("PtaResultList: ~p~n",[PtaResultList]),

    %%% --- Fetch logg result ---
    LoggResult = sbgFtSupport:log_result(TestCaseId),
    ct:pal("LoggResult: ~p~n",[LoggResult]),

    %%% --- Return Result ---
    StartResult ++ PtaResultList ++ LoggResult.

%%% ----------------------------------------------------------------------------
%%% attach_group_comment/1
%%%
%%% Arguments:    Group - atom(), group name
%%%
%%% Description:  Attach brief by group name
%%%
%%% Return:       -
%%% ----------------------------------------------------------------------------
attach_group_comment(Group) ->
    ct:comment("Group ~p started", [Group]).

%%% ----------------------------------------------------------------------------
%%% attach_group_comment/3
%%%
%%% Arguments:    Role - atom(), pcscf | aalg
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%               ExtBgf - boolean() | undefined
%%%
%%% Description:  Attach brief by params
%%%
%%% Return:       -
%%% ----------------------------------------------------------------------------
attach_group_comment(Role, Ipvsn, _ExtBgf = true) ->
    ct:comment("Configure SBG and load PTTS for ~p ~p with BGF", [Ipvsn, Role]);
attach_group_comment(Role, Ipvsn, _ExtBgf) ->
    ct:comment("Configure SBG and load PTTS for ~p ~p without BGF", [Ipvsn, Role]).

%%% ----------------------------------------------------------------------------
%%% base_properties/1
%%%
%%% Arguments:    ConfigList - Proplist, used by JPT and Common Test
%%%
%%% Description:  Extract role,ip version,ext bgf informations added 
%%%                  during group with role initial
%%%
%%% Return:       {Role, Ipvsn, ExtBgf} 
%%%               Role - atom(), pcscf | aalg
%%%               Ipvsn - atom(), ipv4 | ipv6 | both
%%%               MatedPairs - list(), [1 ,2, ... 17]
%%%               ExtBgf - boolean()
%%% ----------------------------------------------------------------------------
base_properties(ConfigList) ->
    Scenario = proplists:get_value(scenario, ConfigList),
    Role = proplists:get_value(role, ConfigList),
    Ipvsn = proplists:get_value(ip_version, ConfigList),
    {Scenario, Role, Ipvsn}.

base_properties(ConfigList, all) ->
    {Scenario, Role, Ipvsn} = base_properties(ConfigList),
    MatedPairs = proplists:get_value(traffic_mated_pairs, ConfigList, [1]),
    ExtBgf = proplists:get_value(ext_bgf, ConfigList, false),
    {Scenario, Role, Ipvsn, MatedPairs, ExtBgf}.

extra_properties(_ConfigList) ->
    [].

%%% ----------------------------------------------------------
%%% #5   TEST CASES
%%% ----------------------------------------------------------

%%% $ChapterH1 Introduction
%%% $Table( (border=yes|text=Revision history)
%%% Rev  | Date      | Who    | Description
%%%
%%% A     2009-12-11  etxulno  Initial full letter version)
%%%
%%% This feature test specification verifies the media source filtering feature in the SGC.
%%% Media source filtering is ordered by the SGC by specifying the "gm/saf" and optionaly the "gm/spf" flags
%%% in the H.248 messages sent to the BGF Server. The address to apply the filter with, is passed
%%% in the SDP c-line for RTP, and the a-line for RTCP.
%%% Basicly, this test specification verifies that the correct flag(s) and SDP are sent to the BGF Server.
%%%
%%% This table shows which flags to set in the different cases.
%%%
%%% "-" means no flags are set.
%%%
%%% "NA" means  not applicable
%%%
%%% "SDP" means that the SDP c-line or a-line is updated, and contains the SIP IP-address
%%%
%%%
%%% $Table( 
%%%                    |off        | SDP IP address | SIP IP address   | SDP IP address and port
%%%
%%% UDP, no NAT         -             saf              saf, SDP          saf,spf
%%%
%%% UDP, NAT            -             NA                saf, SDP          NA
%%%
%%% TCP passive, no NAT -             saf              saf, SDP          saf
%%%
%%% TCP passive, NAT    -             NA                saf, SDP          NA
%%%
%%% TCP active, no NAT  saf, spf      saf,spf         saf, spf, SDP      saf, spf)
%%% Table 1
%%%
%%%
%%%
%%% The following two tables shows in which H.248 message the flags are sent. A "f" denotes that a filtering
%%% flag is present (saf and optionally spf). A "-" denotes that no flags are present.
%%% 
%%%
%%%
%%% Table 2 NAT
%%% $Table( 
%%% SIP           | H.248 | A side | B side
%%%
%%% offer           Add      -        - 
%%% answer          Modify   -        - 
%%% final response  Modify   f        f )
%%% 
%%%
%%%
%%% Table 3 No NAT
%%% $Table( 
%%% SIP           | H.248 | A side| B side
%%%
%%% offer           Add     f            -
%%% answer          Modify  f            f
%%% final response  Modify  f            f)
%%% 
%%%
%%%
%%% $ChapterH1 Test Environment
%%% All tests will be done in a simulated environment.
%%%
%%% $ChapterH2 Hardware
%%% No hardware is used.
%%%
%%% $ChapterH2 Data Transcript
%%%
%%% $ChapterH2 Test Tools
%%% Visual test server, VTS.
%%%
%%% $ChapterH2 Background Activities and Traffic
%%% No background traffic is required.
%%%
%%% $ChapterH2 Based on Documents


%%% $ChapterH1 Test cases


%%% $ChapterH2 Cases where NAT has not been detected
%%% 
%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_001
%%%
%%% $Header Filter set to "SDP IP address", NAT is not detected. UDP
%%%
%%% $Description Verify that the "gm/saf" flag is present in the H.248 messages sent to the BGF.
%%% Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP address"
%%%
%%% Media source filtering with NAT: off
%%%
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF.
%%% 
%%% $Result The following H.248 commands are sent to the BGF: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 3.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_001() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_001(Config) ->
    Header   = "Filter set to 'SDP IP address', NAT is not detected. UDP",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS"]}, {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_002
%%%
%%% $Header Filter set to "SIP IP address", NAT is not detected. UDP
%%%
%%% $Description Verify that "gm/saf" flag is present 
%%% and that the c-line is modified in the H.248 message sent to the BGF.
%%% Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SIP IP address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF.
%%% 
%%% $Result The following H.248 commands are sent to the BGF: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 3,
%%% and the remote descriptor SDP c-line shall contain the filter (SIP IP address).
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF.

%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_002() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_002(Config) ->
    Header   = "Filter set to 'SIP IP address', NAT is not detected. UDP",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SIP_IP_ADDRESS"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_003
%%%
%%% $Header Filter set to "SDP IP address and port", NAT is not detected. UDP
%%%
%%% $Description Verify that the "gm/saf" and "gm/spf" flags are present in the H.248 message sent to the BGF
%%% Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT

%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP address and port"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF.
%%% 
%%% $Result The following H.248 commands are sent to the BGF: ADD, MODIFY, MODIFY.
%%% The "gm/saf" and "gm/spf" flags are sent according to table 3.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_003() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_003(Config) ->
    Header   = "Filter set to 'SDP IP address and port', NAT is not detected. UDP",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS_AND_PORT"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_004
%%%
%%% $Header Filter set to "off", NAT is not detected. UDP
%%%
%%% $Description Verify that no filter flags are present in the H.248 messages sent to the BGF
%%% Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "off"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% No filter flags are sent to the BGF.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_004() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_004(Config) ->
    Header   = "Filter set to 'off', NAT is not detected. UDP",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["OFF"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_005
%%%
%%% $Header Filter set to "SDP IP address", NAT is not detected. TCP passive
%%%
%%% $Description Verify that the "gm/saf" flag is present in the H.248 messages sent to the BGF
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF.
%%% 
%%% $Result The following H.248 commands are sent to the BGF: ADD, MODIFY, MODIFY.
%%% The modify commands shall have the "gm/saf" flag is present.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_005() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_005(Config) ->
    Header = "Header Filter set to 'SDP IP address', NAT is not detected. TCP passive",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS_AND_PORT"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_006
%%%
%%% $Header Filter set to "SDP IP address and port", NAT is not detected. TCP passive
%%%
%%% $Description Verify that the "gm/saf" flag is present in the H.248 messages sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP address and port"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 2.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_006() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_006(Config) ->
    Header = "Header Filter set to 'SDP IP address and port', NAT is not detected. TCP passive",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS_AND_PORT"]},
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_007
%%%
%%% $Header Filter set to "off", NAT is not detected. TCP passive
%%%
%%% $Description Verify that the "gm/saf" flag is present in the H.248 messages sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "off"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 2.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_007() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_007(Config) ->
    Header = "Header Filter set to 'OFF', NAT is not detected. TCP passive",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["OFF"]},
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_008
%%%
%%% $Header Filter set to SIP IP address  NAT is detected, UDP
%%%
%%% $Description Verify that "gm/saf" flag is present 
%%% and that the c-line is modified in the H.248 message sent to the BGF.
%%% Caller is behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: SDP IP-address and port.
%%%
%%% Media source filtering with NAT: "SIP IP address"
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF.
%%% 
%%% $Result The following H.248 commands are sent to the BGF: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 3, and the SDP c-line contains the SIP IP-address.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_008() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_008(Config) ->
    Header   = "Filter set to SIP IP address  NAT is detected, UDP",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS_AND_PORT"]}, 
                   {mediaSourceFilteringWithNAT, ["SIP_IP_ADDRESS"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------
%%% $Id sbg_msf_009
%%%
%%% $Header Filter set to "off"  NAT is detected, UDP
%%%
%%% $Description Verify that no filter flags (gm/saf, gm/spf) are present in the H.248 message sent to the BGF Server
%%% Caller is behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: SDP IP-address and port.
%%%
%%% Media source filtering with NAT: "off"
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% No filter flags are sent to the BGF Server.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_009() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_009(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_010
%%%
%%% $Header Filter set to "off", no NAT, TCP active
%%%
%%% $Description Verify that the "gm/saf" and the "gm/spf" flags are present in the H.248 message sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is active.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "off"
%%%
%%% Media source filtering with NAT: off.
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The modify command shall have the "gm/saf" and the "gm/spf" flags are present.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_010() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_010(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_011
%%%
%%% $Header Filter set to "SIP IP address", NAT is not detected. TCP passive
%%%
%%% $Description Verify that the "gm/saf" flag is present
%%% and that the c-line is modified in the H.248 message sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SIP IP address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 2.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_011() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_011(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_012
%%%
%%% $Header Filter set to "SDP IP-address", no NAT, TCP active
%%%
%%% $Description Verify that "gm/saf" and "gm/spf" flags are present in the H.248 message sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is active.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP-address"
%%%
%%% Media source filtering with NAT: off.
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" and "gm/spf" flags are sent in the modify commands.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_012() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_012(Config) ->
    Header = "Filter set to SDP IP-address, no NAT, TCP active",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SDP_IP_ADDRESS"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_013
%%%
%%% $Header Filter set to "SIP IP-address", no NAT, TCP active
%%%
%%% $Description Verify that that "gm/saf" and "gm/spf" flags are present, 
%%% and that the SDP c-line is updated in the H.248 message sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is active.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SIP IP-address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The modify commands shall have the "gm/saf" and the "gm/spf" flags present,
%%% and the remote descriptor SDP c-line shall contain the filter (SIP IP address).
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_013() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_013(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_014
%%%
%%% $Header Filter set to "SDP IP-address and port", no NAT, TCP active
%%%
%%% $Description Verify that the "gm/saf" and "gm/spf" flags are present in the H.248 message sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is TCP. Connection side is active.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP-address and port"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" and "gm/spf" flags are sent according to table 2.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_014() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_014(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_015
%%%
%%% $Header Filter set to "off", NAT, TCP passive
%%%
%%% $Description Verify that no filter flags are present in the H.248 message
%%% sent to the BGF Server
%%% Caller is  behind a NAT. Protocol is TCP. Connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP-address and port"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% No filter flags are present.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_015() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_015(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_016
%%%
%%% $Header Filter set to "SIP IP-address", NAT, TCP passive
%%%
%%% $Description Verify that the "gm/saf" flags are present in the H.248 message,
%%% and that the c-line is modified in the H.248 message sent to the BGF Server
%%% Caller is  behind a NAT. Protocol is TCP. Connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP-address and port"
%%%
%%% Media source filtering with NAT: "SIP IP-address"
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 3,
%%% and the remote descriptor SDP c-line shall contain the filter (SIP IP address)
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_016() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_016(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_017
%%%
%%% $Header Filter set to "off", NAT, TCP and UDP
%%%
%%% $Description Verify that two streams are handled correct with respect to media source filtering.
%%% Caller is  behind a NAT. Protocols are UDP and TCP. TCP connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP-address and port"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call, with one UDP/RTP stream and one TCP stream from access to core, 
%%% with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% No filter flags are sent to the BGF Server.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_017() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_017(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_017a
%%%
%%% $Header Filter set to "SIP IP-address", NAT, TCP and UDP
%%%
%%% $Description Verify that two streams are handled correct with respect to media source filtering.
%%% Caller is behind a NAT. Protocols are UDP and TCP. TCP connection side is passive.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SDP IP-address and port"
%%%
%%% Media source filtering with NAT: "SIP IP-address
%%%
%%% $Action Set up a call, with one UDP/RTP stream and one TCP stream from access to core, 
%%% with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 3.
%%% The remote descriptor SDP c-line for the RTP stream shall contain the filter for UDP (SIP IP address)
%%% The remote descriptor SDP c-line for the TCP stream shall contain the filter for TCP (SIP IP address)
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_017a() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_017a(_Config) ->
    ok.

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_018
%%%
%%% $Header Filter set to "SIP IP-address", no NAT, UDP, RTCP spec in a-line
%%%
%%% $Description Verify that the "gm/saf" flag is present, and that the remote descriptor SDP c-line,
%%% and a-line are modified in the H.248 messages sent to the BGF Server. Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SIP IP-address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The modify commands shall have the "gm/saf" flag present.
%%% The remote descriptor SDP c-line shall contain the filter (SIP IP-address).
%%% The a-line shall contain the RTCP source address.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_018() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_018(Config) ->
    Header   = "Filter set to 'SIP IP-address', no NAT, UDP, RTCP spec in a-line",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SIP_IP_ADDRESS"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_019
%%%
%%% $Header Filter set to "SIP IP-address", NAT, UDP, RTCP spec in a-line
%%%
%%% $Description Verify that the "gm/saf" flag is present, and the the remote descriptor SDP c-line,
%%% and a-line are modified in the H.248 messages sent to the BGF Server. Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority Low
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SIP IP-address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The "gm/saf" flag is sent according to table 3.
%%% The remote descriptor SDP c-line shall contain the filter (SIP IP-address).
%%% The a-line shall contain the RTCP SIP IP-address.
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.
%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_019() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_019(Config) ->
    Header   = "Filter set to SIP IP-address, NAT, UDP, RTCP spec in a-line",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SIP_IP_ADDRESS"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% ----------------------------------------------------------------------
%%% $Id sbg_msf_020
%%%
%%% $Header Filter set to "SIP IP address", NAT is not detected. UDP/RTP, RTCP
%%%
%%% $Description Verify that "gm/saf" flag is present 
%%% and that the c-line, and the a-line is modified in the H.248 message sent to the BGF Server.
%%% Caller is not behind a NAT. Protocol is UDP.
%%%
%%% $Reference -
%%%
%%% $Requirements -
%%%
%%% $Priority High
%%%
%%% $History New
%%%
%%% $Comments Tested in SSIT
%%% 
%%% $Precondition
%%% The filtering settings are configured like this:
%%%
%%% Media source filtering without NAT: "SIP IP address"
%%%
%%% Media source filtering with NAT: off
%%%
%%% $Action Set up a call from access to core, with the following SIP message sequence:
%%% INVITE, 180 Ringing, 200 OK, ACK. Check the H.248 commands sent to the BGF Server.
%%% 
%%% $Result The following H.248 commands are sent to the BGF Server: ADD, MODIFY, MODIFY.
%%% The RTCP stream is defined in an additional a-line.
%%% The "gm/saf" flag is sent according to table 2,
%%% and the remote descriptor SDP c-line, and a-line shall contain the filter (SIP IP address).
%%%
%%% $Action Disconnect the call by sending a SIP BYE.
%%% 
%%% $Result A H.248 SUBTRACT is sent to the BGF Server.

%%%
%%% $Postcondition -
%%%
%%% $End
%%% 

sbg_msf_020() ->
    [{timetrap, {minutes, 3}}].

sbg_msf_020(Config) ->
    Header   = "Filter set to SIP IP address, NAT is not detected. UDP/RTP, RTCP",

    {Scenario, Role, Ipvsn} = base_properties(Config),

    MoInfo = sig_mo_info(Scenario, Role, access, Ipvsn),
    MergedAttrs = [{mediaSourceFilteringWithoutNAT, ["SIP_IP_ADDRESS"]}, 
                   {mediaSourceFilteringWithNAT, ["OFF"]}],

    run_test_case_with_conf_list(?TCID, Header, Config, [{MoInfo, MergedAttrs, merge}]).

%%% $ChapterH1 RS SOC Compatibility List
%%% $Table( 
%%% Req. Spec.          | Req. No.          | Req. Slogan                             | Related TC
%%%
%%% IMS-GW SBG RG000235   105 65-0255/00741    Media source filtering without NAT -     sbg_msf_001,
%%%                                                                   Configuration
%%%                                                                                     sbg_msf_002,
%%%                                                                                     sbg_msf_020,
%%%                                                                                     sbg_msf_003,
%%%                                                                                     sbg_msf_004,
%%%                                                                                     sbg_msf_005,
%%%                                                                                     sbg_msf_011,
%%%                                                                                     sbg_msf_006,
%%%                                                                                     sbg_msf_007,
%%%                                                                                     sbg_msf_010,
%%%                                                                                     sbg_msf_012,
%%%                                                                                     sbg_msf_013,
%%%                                                                                     sbg_msf_014,
%%%                                                                                     sbg_msf_018
%%% IMS-GW SBG RG000235   105 65-0255/00740    Media source filtering with NAT -         sbg_msf_008,
%%%                                                                Configuration
%%%                                                                                     sbg_msf_009,
%%%                                                                                     sbg_msf_015,
%%%                                                                                     sbg_msf_016,
%%%                                                                                     sbg_msf_017,
%%%                                                                                     sbg_msf_017a,
%%%                                                                                     sbg_msf_019
%%%
%%% IMS-GW SBG RG000235   105 65-0255/00765    Media source filtering without NAT       sbg_msf_001,
%%%                                                                                     sbg_msf_002,
%%%                                                                                     sbg_msf_020,
%%%                                                                                     sbg_msf_003,
%%%                                                                                     sbg_msf_004,
%%%                                                                                     sbg_msf_005,
%%%                                                                                     sbg_msf_011,
%%%                                                                                     sbg_msf_006,
%%%                                                                                     sbg_msf_007,
%%%                                                                                     sbg_msf_010,
%%%                                                                                     sbg_msf_012,
%%%                                                                                     sbg_msf_013,
%%%                                                                                     sbg_msf_014,
%%%                                                                                     sbg_msf_018
%%%
%%% IMS-GW SBG RG000235   105 65-0255/00766    Media source filtering with NAT          sbg_msf_008,
%%%                                                                                     sbg_msf_009,
%%%                                                                                     sbg_msf_015,
%%%                                                                                     sbg_msf_016,
%%%                                                                                     sbg_msf_017,
%%%                                                                                     sbg_msf_017a,
%%%                                                                                     sbg_msf_019)
%%%
%%% $ChapterH1 Abbreviations
%%%
%%% $Table( 
%%% Abbreviation | Description
%%%
%%% BGF            Border Gateway Function
%%% NAT            Network Address Translation
%%% SGC            Session Gateway Controler
%%% RTP            Real Time Protocol
%%% RTCP           Real Time Control Protocol
%%% TCP            Transmission Control Protocol
%%% UDP            User Datagram Protocol
%%% )
%%%

%%% $ChapterH1 References
%%%
%%% $Table(  
%%% Ref  | Name                                           | Docno
%%%
%%% 1      RS Security Improvements                         IMS-GW SBG RG000235 Rev B
%%% )
%%%
%%% $ChapterH1 LSV scope proposal
%%%
%%% $Table(
%%% Testcase ID
%%%
%%% sbg_msf_020
%%% sbg_msf_005
%%% sbg_msf_007
%%% sbg_msf_008
%%% sbg_msf_015
%%% sbg_msf_016
%%%)
