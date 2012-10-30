From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Oct 2012 16:07:22 +0000
Subject: [PATCH 1/5] ARM: at91: atmel-ssc: add platform device id table
In-Reply-To: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20121030160722.GW4511@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 06:17:55PM +0800, Bo Shen wrote:
> Using platform device id to check whether the Atmel SOC support dma for
> data transfer
> 
> If match "at91rm9200_ssc" which does not support DMA transfer
> If match "at91sam9g45_ssc" which support DMA transfer

Any comments on this from that Atmel folks?  If I don't see something
I'll probably just apply.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/fa8dc4a7/attachment.sig>
