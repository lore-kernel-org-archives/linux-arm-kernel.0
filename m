From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 8 Sep 2011 01:45:49 +0200
Subject: [PATCH V2] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <4E673B69.3030807@denx.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<20110907093017.GA1912@pengutronix.de> <4E673B69.3030807@denx.de>
Message-ID: <201109080145.49908.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 07, 2011 11:37:45 AM Stefano Babic wrote:
> On 09/07/2011 11:30 AM, Wolfram Sang wrote:
> > On Wed, Sep 07, 2011 at 08:45:31AM +0200, Stefano Babic wrote:
> >> Added initial support for DENX M28 module and M28EVK
> >> board. Ethernet(FEC), SDHC, Display are supported.
> >> 
> >> Signed-off-by: Stefano Babic <sbabic@denx.de>
> > 
> > Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> > 
> > May I ask what bootloader do you use? The FSL-uboot or will there be mxs
> > support in mainline u-boot?
> 
> Of course. I have tested the kernel using still the FSL-uboot, but
> someone of us is porting the code to the actual u-boot mainline. Not yet
> ready, but work is in progress, and patches should be submitted soon to
> the mailing list.

I can confirm (from some internal source I can't yet disclose) that this kernel 
works with mainline u-boot too.

Cheers

> 
> Best regards,
> Stefano
