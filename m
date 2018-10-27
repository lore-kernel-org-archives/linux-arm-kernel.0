From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Oct 2018 11:33:00 +0800
Subject: [xlnx:master 2130/2130] fs/afs/security.c:117:9: error: incompatible
 types in comparison expression (different address spaces)
Message-ID: <201810271156.qhwYdfiT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e0652408f6a3e2464aed159fa83dc3b2a2aadefd
commit: e0652408f6a3e2464aed159fa83dc3b2a2aadefd [2130/2130] ASoC: xlnx: Set missing/invalid channel count to default value in consumer format
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout e0652408f6a3e2464aed159fa83dc3b2a2aadefd
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> fs/afs/security.c:117:9: error: incompatible types in comparison expression (different address spaces)
   fs/afs/security.c:246:27: error: incompatible types in comparison expression (different address spaces)
--
   net/xfrm/xfrm_policy.c:593:22: warning: incorrect type in assignment (different address spaces)
   net/xfrm/xfrm_policy.c:593:22:    expected struct hlist_head *odst
   net/xfrm/xfrm_policy.c:593:22:    got struct hlist_head [noderef] <asn:4>*table
>> include/linux/netfilter.h:343:20: error: incompatible types in comparison expression (different address spaces)
   net/xfrm/xfrm_policy.c:2777:43: error: incompatible types in comparison expression (different address spaces)
   net/xfrm/xfrm_policy.c:2848:29: warning: incorrect type in assignment (different address spaces)
   net/xfrm/xfrm_policy.c:2848:29:    expected struct hlist_head [noderef] <asn:4>*table
   net/xfrm/xfrm_policy.c:2848:29:    got struct hlist_head *
   net/xfrm/xfrm_policy.c:2876:36: warning: incorrect type in argument 1 (different address spaces)
   net/xfrm/xfrm_policy.c:2876:36:    expected struct hlist_head *n
   net/xfrm/xfrm_policy.c:2876:36:    got struct hlist_head [noderef] <asn:4>*table
   net/xfrm/xfrm_policy.c:2903:17: warning: incorrect type in argument 1 (different address spaces)
   net/xfrm/xfrm_policy.c:2903:17:    expected struct hlist_head const *h
   net/xfrm/xfrm_policy.c:2903:17:    got struct hlist_head [noderef] <asn:4>*table
   net/xfrm/xfrm_policy.c:2904:36: warning: incorrect type in argument 1 (different address spaces)
   net/xfrm/xfrm_policy.c:2904:36:    expected struct hlist_head *n
   net/xfrm/xfrm_policy.c:2904:36:    got struct hlist_head [noderef] <asn:4>*table
   net/xfrm/xfrm_policy.c:119:9: warning: context imbalance in 'xfrm_policy_get_afinfo' - different lock contexts for basic block
   include/linux/rcupdate.h:685:9: warning: context imbalance in '__xfrm_dst_lookup' - unexpected unlock
   net/xfrm/xfrm_policy.c:900:25: warning: dereference of noderef expression
   net/xfrm/xfrm_policy.c:958:25: warning: dereference of noderef expression
   include/linux/rcupdate.h:685:9: warning: context imbalance in 'xfrm_get_saddr' - unexpected unlock
   include/linux/rcupdate.h:685:9: warning: context imbalance in 'xfrm_get_tos' - unexpected unlock
   include/linux/rcupdate.h:685:9: warning: context imbalance in 'xfrm_bundle_create' - unexpected unlock
   include/linux/rcupdate.h:685:9: warning: context imbalance in 'xfrm_create_dummy_bundle' - unexpected unlock
   include/linux/rcupdate.h:685:9: warning: context imbalance in 'make_blackhole' - unexpected unlock
   include/linux/rcupdate.h:685:9: warning: context imbalance in '__xfrm_decode_session' - unexpected unlock
--
>> drivers/md/multipath.c:45:40: error: incompatible types in comparison expression (different address spaces)
   drivers/md/multipath.c:156:40: error: incompatible types in comparison expression (different address spaces)
   drivers/md/multipath.c:170:40: error: incompatible types in comparison expression (different address spaces)
--
   fs/exofs/ore_raid.c:77:60: warning: Variable length array is used.
   fs/exofs/ore_raid.c:80:44: warning: Variable length array is used.
   fs/exofs/ore_raid.c:81:47: warning: Variable length array is used.
   fs/exofs/ore_raid.c:82:43: warning: Variable length array is used.
   fs/exofs/ore_raid.c:83:26: warning: Variable length array is used.
>> fs/exofs/ore_raid.c:133:17: error: bad argument type for ++/--
   fs/exofs/ore_raid.c:95:64: warning: division by zero
   fs/exofs/ore_raid.c:116:36: warning: division by zero
--
>> drivers/net/ethernet/chelsio/cxgb3/l2t.h:134:13: error: incompatible types in comparison expression (different address spaces)
>> drivers/net/ethernet/chelsio/cxgb3/l2t.h:134:13: error: incompatible types in comparison expression (different address spaces)
>> drivers/net/ethernet/chelsio/cxgb3/l2t.h:134:13: error: incompatible types in comparison expression (different address spaces)
>> drivers/net/ethernet/chelsio/cxgb3/l2t.h:134:13: error: incompatible types in comparison expression (different address spaces)
>> drivers/net/ethernet/chelsio/cxgb3/l2t.h:134:13: error: incompatible types in comparison expression (different address spaces)
--
>> drivers/net/ethernet/chelsio/cxgb3/l2t.c:326:13: error: incompatible types in comparison expression (different address spaces)
   drivers/net/ethernet/chelsio/cxgb3/l2t.c:402:30: error: incompatible types in comparison expression (different address spaces)
--
>> drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:1145:42: error: incompatible types in comparison expression (different address spaces)
>> drivers/net/ethernet/chelsio/cxgb3/l2t.h:134:13: error: incompatible types in comparison expression (different address spaces)
   drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:1259:9: error: incompatible types in comparison expression (different address spaces)
   drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:1301:13: error: incompatible types in comparison expression (different address spaces)
   drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:1303:9: error: incompatible types in comparison expression (different address spaces)
--
   net/netfilter/nfnetlink_cttimeout.c:57:67: warning: Variable length array is used.
>> net/netfilter/nfnetlink_cttimeout.c:297:62: error: incompatible types in comparison expression (different base types)
   net/netfilter/nfnetlink_cttimeout.c:606:9: error: incompatible types in comparison expression (different address spaces)
   net/netfilter/nfnetlink_cttimeout.c:607:9: error: incompatible types in comparison expression (different address spaces)
   net/netfilter/nfnetlink_cttimeout.c:624:9: error: incompatible types in comparison expression (different address spaces)
   net/netfilter/nfnetlink_cttimeout.c:625:9: error: incompatible types in comparison expression (different address spaces)
--
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
--
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
--
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
>> net/netlabel/netlabel_addrlist.h:90:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
   net/netlabel/netlabel_addrlist.h:157:21: error: incompatible types in comparison expression (different address spaces)
..

vim +117 fs/afs/security.c

00d3b7a4 David Howells           2007-04-26  105  
00d3b7a4 David Howells           2007-04-26  106  /*
00d3b7a4 David Howells           2007-04-26  107   * clear the permit cache on a directory vnode
00d3b7a4 David Howells           2007-04-26  108   */
00d3b7a4 David Howells           2007-04-26  109  void afs_clear_permits(struct afs_vnode *vnode)
00d3b7a4 David Howells           2007-04-26  110  {
00d3b7a4 David Howells           2007-04-26  111  	struct afs_permits *permits;
00d3b7a4 David Howells           2007-04-26  112  
416351f2 David Howells           2007-05-09  113  	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
00d3b7a4 David Howells           2007-04-26  114  
00d3b7a4 David Howells           2007-04-26  115  	mutex_lock(&vnode->permits_lock);
00d3b7a4 David Howells           2007-04-26  116  	permits = vnode->permits;
df8a09d1 Andreea-Cristina Bernat 2017-03-16 @117  	RCU_INIT_POINTER(vnode->permits, NULL);
00d3b7a4 David Howells           2007-04-26  118  	mutex_unlock(&vnode->permits_lock);
00d3b7a4 David Howells           2007-04-26  119  
00d3b7a4 David Howells           2007-04-26  120  	if (permits)
00d3b7a4 David Howells           2007-04-26  121  		call_rcu(&permits->rcu, afs_zap_permits);
00d3b7a4 David Howells           2007-04-26  122  	_leave("");
00d3b7a4 David Howells           2007-04-26  123  }
00d3b7a4 David Howells           2007-04-26  124  

:::::: The code at line 117 was first introduced by commit
:::::: df8a09d1b8f9e693ec3f6b7e0162fc817f2cf0db afs: security: Replace rcu_assign_pointer() with RCU_INIT_POINTER()

:::::: TO: Andreea-Cristina Bernat <bernat.ada@gmail.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181027/1c198c25/attachment-0001.gz>
