From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 Aug 2014 10:33:12 +0100
Subject: [RESEND PATCH V2] devicetree: Dialog Semiconductor consolidate
 existing vendor prefixes to standardise on 'dlg'
In-Reply-To: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
References: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
Message-ID: <20140826093312.GI9574@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Aug 2014, Opensource [Steve Twiss] wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> This patch series updates the device tree vendor prefix for
> Dialog Semiconductor.
> 
> Various methods are currently used throughout the kernel: 'diasemi',
> 'dialog' and 'dlg'. Others have also been suggested.
> 
> This patch set aims to consolidate the usage of the vendor prefix to
> use a common standard. The prefix 'dlg' is used.
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---

[...]

> Hi Lee,
> 
> This is a resend according to requests for e-mail reformatting and removal
> of '[]' in From: and Signed-off-by: tags. There are no patch alterations
> from RFC V2.
> 
> I have got the Ack for the two remaining files r8a7790-lager.dts and
> r8a7791-koelsch.dts because of the previous request for SHMobile to Ack
> their part of the patch.
> - http://www.spinics.net/lists/arm-kernel/msg349289.html
> - https://lkml.org/lkml/2014/6/11/273
> 
> I think this is it. But, if I am missing anything or there are problems, can
> I get a quick explanation in the reply so I can fix it and move forwards
> please?
> 
> In full:
> Acked-by the following people so far:

When you say "so far", does that mean you're missing Acks still?

If you have the full-set I will apply this and send out the necessary
pull-request(s).

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
