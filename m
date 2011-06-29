From: silesh@ti.com (Silesh C V)
Date: Wed, 29 Jun 2011 10:26:38 +0900
Subject: [PATCH] OMAP: HSMMC: Fix GPIO muxing
In-Reply-To: <4E09DC13.3010304@compulab.co.il>
References: <1309250759-18472-1-git-send-email-silesh@ti.com>
	<4E09DC13.3010304@compulab.co.il>
Message-ID: <BANLkTin19ZDH97zXsDPgfQzX8bjxp=Hwjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Tue, Jun 28, 2011 at 10:50 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Silesh,
>
>
> IMHO, you should not separate the patches
> (this one and OMAP: 4430SDP: Register the card detect GPIO properly),
> because the 4430sdp fix should come before or together with this patch,
> otherwise 4430sdp will be broken, once this patch is applied.

4430SDP is already broken because it requests/configures GPIO 0. But
as you said if this patch goes before the SDP fix, the driver will do
Muxing of the pad (as this pad fixes that for GPIO 0)also. Thanks for
the suggestion.

>
> You can either make it a one patch or make it a single properly numbered series.
>

I will send it as a series.

Regards,
Silesh
