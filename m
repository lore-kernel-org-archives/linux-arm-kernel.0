From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Nov 2012 10:25:47 +0900
Subject: [Patch v6 2/4] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <1352887751-21848-3-git-send-email-voice.shen@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20121116012544.GI4387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 06:09:09PM +0800, Bo Shen wrote:
> change the method for register dai and pcm
>   - let the atmel-ssc-dai no longer as a standalone platform device
>   - remap ssc and then register dai directly
>   - register pcm from dai directly
>   - modify the code which related with this change

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/c19ed5dd/attachment.sig>
