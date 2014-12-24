From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Dec 2014 12:43:51 +0000
Subject: [PATCH v2 0/3] ASoC: rockchip: i2s: fix watermark to 16 and
 maxburst to 4
In-Reply-To: <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
 <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20141224124351.GA17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 24, 2014 at 05:36:59PM +0800, Jianqun Xu wrote:
> To make Bus DMA works more efficiency, DMA may work in burst mode,
>    we set the watermark of transmit and receive reach to 16 bits.

Applied all, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141224/52df34b9/attachment.sig>
