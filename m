From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Nov 2012 15:12:55 +0900
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
In-Reply-To: <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121116061250.GP4387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 02:03:57PM +0800, Bo Shen wrote:
> Add pinctrl consumer for atmel ssc peripheral
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> Resend:
>   Split one patch into two.
>     - one add pinctrl nodes
>     - one add pinctrl consumer

No, this isn't what was meant - the idea is to send only the addition of
pinctrl data as one patch, based off the ASoC branch instead of -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/c57f0c06/attachment.sig>
