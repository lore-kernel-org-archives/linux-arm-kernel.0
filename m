From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Aug 2015 11:48:19 +0100
Subject: [PATCH v2] ASoC: rockchip: fix a misjudgement by return
In-Reply-To: <1440559244-17634-1-git-send-email-zhengxing@rock-chips.com>
References: <1440559244-17634-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150826104819.GO12878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 11:20:44AM +0800, Xing Zheng wrote:
> Being careless, judge the return value of snd_soc_card_jack_new
> is opposite, so it should be fixed.

This patch has been applied already.  If any changes are required to
already applied patches please send incremental patches against current
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150826/2f577cbf/attachment.sig>
