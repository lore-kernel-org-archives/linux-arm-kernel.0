From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:36:13 -0700
Subject: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of
 rockchip i2s controller
In-Reply-To: <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140913163613.GI7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 08:42:12AM +0800, Jianqun wrote:
> Reference rockchip I2S controller TRM, modify some registers' property
> I2S_FIFOLR: read / write, but not volatile, not precious
> I2S_INTSR: read / write
> I2S_CLR: volatile, register value will be cleared by read

Applied, again this is a bug fix (volatile and precious being wrong seem
like bugs) so should have been earlier in the series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/cc829331/attachment-0001.sig>
