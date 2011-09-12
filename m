From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 12 Sep 2011 15:33:46 -0500
Subject: [PATCH 0/7] ASoC: ep93xx: convert to use snd_soc_register_card()
In-Reply-To: <20110912155921.GA2657@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<4E6D4100.7060007@gmail.com>
	<CABS+qY15T_fR4o4kxBYguXH64wzaCrypJZdaduDDht_9Vqokfg@mail.gmail.com>
	<20110912101939.GA2953@opensource.wolfsonmicro.com>,
	<20110912155921.GA2657@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DABAF29@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2011 8:59 AM, Mika Westerberg wrote:
> On Mon, Sep 12, 2011 at 11:19:39AM +0100, Mark Brown wrote:
>> On Mon, Sep 12, 2011 at 05:55:49AM +0100, Girdwood, Liam wrote:
>>
>>> ASoC parts
>>
>>> Acked-by: Liam Girdwood <lrg@ti.com>
>>
>> I'm happy with them too - they should probably all go in together,
>> do folks want me to apply them to ASoC or should we merge via the ARM
>> tree?
>
> I'm kind of hoping that Hartley would (N)ACK the mach-ep93xx parts so that
> they could be merged via ASoC tree.

Mika,

I'm on vacation this week and did not get a chance to review your patches. I did take
a quick glance at them and didn't see any issues.

I think Ryan Mallon looked them over and gave you a Reviewed-by signoff.  Go with
that one for now.  I'll look the patches over next week and if they have not been merged
into linux-next by then I'll give you the appropriate sign-off or additional comments.

Thanks for doing this!

Regards,
Hartley
