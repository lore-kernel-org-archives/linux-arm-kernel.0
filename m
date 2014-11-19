From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Nov 2014 10:10:33 +0000
Subject: [PATCH v2 1/2] ASoC: rockchip-i2s: dt: add an optional property
 "i2s_clk_out"
In-Reply-To: <1416384447-29391-1-git-send-email-jay.xu@rock-chips.com>
References: <1416366365-4632-2-git-send-email-jay.xu@rock-chips.com>
 <1416384447-29391-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20141119101033.GW22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 04:07:27PM +0800, Jianqun Xu wrote:
> Add an property "i2s_clk_out", which enables to output clock to outside
> of rockchip SoCs. Let's make it optional since not each board needs it.

Don't send new patches as individual followups to patches in the series,
repost the series.  It becomes very difficult to follow what the current
series is (which is the latest version of everything, what ordering, is
everything still in the current version of the series).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/0e11b3c8/attachment.sig>
