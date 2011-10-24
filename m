From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 24 Oct 2011 09:15:38 +0800
Subject: [GIT PULL] i.MX6Q support
In-Reply-To: <20111020211834.GF21648@n2100.arm.linux.org.uk>
References: <20111020171158.GJ32007@S2100-06.ap.freescale.net>
	<20111020211834.GF21648@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4z7AUQmfH47kmjBvGTtwoKWitOH6WWx5cRRmz51-+hYFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Oct 21, 2011 at 01:11:59AM +0800, Shawn Guo wrote:
>> Please pull imx6q series. ?It's based on v3.1-rc10 with the following
>> branches merged plus a number of cache-l2x0 patches currently sitting
>> on rmk/for-next.
>
> Don't do that. ?If there's something you need, _ask_ me. ?The L2x0
> patches got shuffled out into their own branch when the SMP and debug
> patches got split out of the 'misc' branch.

does it mean i can rebase the prima2 l2 patch based on the rmk/l2
branch with the two commits i need:
ARM: 7090/1: CACHE-L2X0: filter start address can be 0 and is often 0;
ARM: 7114/1: cache-l2x0: add resume entry for l2 in secure mode

and let Arnd pull my prima2 l2 patches?
>
Thanks
barry
