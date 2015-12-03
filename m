From: asamson@codeaurora.org (Azriel Samson)
Date: Wed, 2 Dec 2015 21:37:03 -0700
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <1449096562.6139.74.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <002101d12c66$ae985440$0bc8fcc0$@codeaurora.org>
 <1449096562.6139.74.camel@infradead.org>
Message-ID: <000b01d12d84$4313a930$c93afb90$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

> I pushed out a kexec-v12.1 branch to my linux-kexec repo [1] with fixes.
Could you test it with both kexec reboot and kdump?  For kdump, use
something like:
 > CMDLINE += 'crashkernel=64M at 2240M'

For kdump, I also require a version of the patch "arm64/kexec: Add support
for kexec-lite". Without this, the dump capture kernel cannot find the
device tree even on v11 that I tested.

Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,?
a Linux Foundation Collaborative Project
