From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Nov 2015 12:02:42 +0000
Subject: [PATCH v3 3/3] ASoC: rockchip: i2s: share tx/rx lrck when
 symmetric_rates enabled
In-Reply-To: <1446773891-32174-4-git-send-email-sugar.zhang@rock-chips.com>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
 <1446773891-32174-4-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20151106120241.GI18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 09:38:11AM +0800, Sugar Zhang wrote:
> we share lrck_tx to lrck_rx only if when both i2s symmetric_rates and
> dai_link symmetric_rates enabled.

This looks good but seems to depend on patch 1 so I can't apply it yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/9d340c69/attachment.sig>
