From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Feb 2012 12:35:24 +0000
Subject: [PATCH 2/6] ASoC: fsl: align mpc8610_hpcd with p1022_ds on
 getting codec node
In-Reply-To: <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120228123524.GF3683@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:09:37PM +0800, Shawn Guo wrote:
> Align mpc8610_hpcd with p1022_ds on getting codec node by just calling
> of_parse_phandle.  The bonus point of doing that is we can save
> exporting get_node_by_phandle_name() when we consolidate the common
> bits between mpc8610_hpcd and p1022_ds into a module, which can be
> shared by more machine drivers added later.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120228/f1a4631b/attachment.sig>
