From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 22 Nov 2010 13:56:54 -0800
Subject: [PATCH 0/8] OMAP2+: hwmod core upgrades for 2.6.38: first set
In-Reply-To: <alpine.DEB.2.00.1011160945100.32653@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 16 Nov 2010 09:47:26 -0700 (MST)")
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
	<alpine.DEB.2.00.1011160945100.32653@utopia.booyaka.com>
Message-ID: <87y68lnhsp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 16 Nov 2010, Paul Walmsley wrote:
>
>> This patch series contains upgrades for the OMAP2+ hwmod core
>> code, intended for 2.6.38.  Most of these patches were developed
>> in response to use-cases discovered while converting device
>> drivers to use the hwmod code.
>> 
>> Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.
>
> Just FYI, this branch 'hwmod_a_2.6.38' is available at 
> git://git.pwsan.com/linux-2.6
>
> Warning: it's based on Tony's tree, not the mainline, due to the recent 
> board file changes.

Looks like Tony has collected the board file changes into his
devel-board branch.  Can this rebased there?

That way, I can included it as part of the PM branch testing without
having to pull in master.

Thanks,

Kevin
