From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 19:07:32 +0200
Subject: [PATCH 4/14] ARM: LPC32xx: Add DMA configuration to platform data
In-Reply-To: <20120611111029.GF11168@n2100.arm.linux.org.uk>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-5-git-send-email-stigge@antcom.de>
 <20120611111029.GF11168@n2100.arm.linux.org.uk>
Message-ID: <4FDA1A54.3020206@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

thanks for your note!

On 11/06/12 13:10, Russell King - ARM Linux wrote:
> On Mon, Jun 11, 2012 at 01:02:07PM +0200, Roland Stigge wrote:
>> +static int pl08x_get_signal(struct pl08x_dma_chan *ch)
>> +{
>> +	return ch->cd->min_signal;
>> +}
>> +
>> +static void pl08x_put_signal(struct pl08x_dma_chan *ch)
>> +{
>> +}
> 
> These change in my unstable/dma-pl08x branch, patches have been posted
> already, but I don't deem them to be totally stable yet.  Waiting on
> OMAP people to get their mainline kernel restored to a buildable state
> so I can continue my DMA engine work.

We have a few options here:

1) Take the patch as I posted it (needs adjustments as soon as the API
changed and becomes stable)

2) Remove the DMA related patches from the LPC32xx series for now (which
would be unfortunate)

3) Let me build upon some tree that already looks worthwhile to play
with already (which one?)

What would you suggest?

Thanks in advance,

Roland
