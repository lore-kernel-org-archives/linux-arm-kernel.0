From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Nov 2014 11:01:17 +0000
Subject: [PATCH] ASoC: pxa: prepare/unprepare clocks in pxa-ssp
In-Reply-To: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
References: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141117110117.GW2722@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 15, 2014 at 10:51:46PM +0300, Dmitry Eremin-Solenikov wrote:
> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unrepapre().

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/fd175792/attachment.sig>
