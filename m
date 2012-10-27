From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 27 Oct 2012 23:14:23 +0100
Subject: [PATCH 5/5] ASoC: sam9g20_wm8731: fix the issue for non-DT kernel
In-Reply-To: <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
Message-ID: <20121027221420.GN4564@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 06:17:59PM +0800, Bo Shen wrote:
> When register platform from DAIs, the platform device to PCM no longer
> needed. So, fix it with this patch

This should be squashed into the change which changes the registeration
to ensure that we don't get both methods used simultaneously.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121027/64dc5f06/attachment.sig>
