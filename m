From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Wed, 26 Jan 2011 15:46:21 +0530
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110125192836.GP13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
	<AANLkTi=PqUBrrZwWbipXDNxoKrcX8MefZjdeaOrgPApV@mail.gmail.com>
	<20110125192836.GP13589@atomide.com>
Message-ID: <AANLkTik6zf1GcPHxSv5pBOHVf=GjCPMuNf-qvpTgiyqT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 12:58 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Poddar, Sourav <sourav.poddar@ti.com> [110125 07:45]:
>>
>> Just FYI, I observed similar results on OMAP4 for these patches.
>> For OMAP2420, OMAP2430 and OMAP3430 SDPs, you can add my boot
>> Tested-by: Sourav Poddar<sourav.poddar@ti.com>
>
> Thanks, just posted third patch to this thread that fixes things
> for omap4, care to give that a try too?
>

I applied the third patch and now its booting
fine for OMAP4 also. :)

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
