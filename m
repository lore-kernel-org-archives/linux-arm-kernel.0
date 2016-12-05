From: maninder1.s@samsung.com (=?UTF-8?B?TWFuaW5kZXIgU2luZ2g=?=)
Date: Mon, 05 Dec 2016 08:18:03 +0000
Subject: =?UTF-8?B?UkU6IFJlOiBbUEFUQ0ggMS8yXSBhcm02NDogQ29ycmVjdGlu?=
 =?UTF-8?B?ZyBmb3JtYXQgc3BlY2lmaWVyIGZvciBwcmludGluIDY0IGJp?=
 =?UTF-8?B?dCBhZGRyZXNzZXM=?=
References: <1480493036-47334-1-git-send-email-maninder1.s@samsung.com>
 <CGME20161130105054epcas2p2d8e6fbfc65564ff74c646e1ca00d3bf5@epcas2p2.samsung.com>
Message-ID: <20161205081803epcms5p508a7587d144d706b7ce86ff611a833e4@epcms5p5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?
Hi Will,

>There are a bunch of these you haven't caught:
>
....
>arch/arm64/mm/mmu.c:            pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
>
>so it would probably make sense to fix these to be consistent.
>
>Will

All changes are sent in new patch except kvm changes, because for kvm we don't not much idea.


>arch/arm64/kernel/signal32.c:           pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
>arch/arm64/kernel/signal32.c:           pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",

and signal32 fiel changes are not required, because it meant only for 32 bit.

--------------------
Thanks and Regards,
Maninder Singh
