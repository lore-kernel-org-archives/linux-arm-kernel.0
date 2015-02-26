From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Feb 2015 11:36:41 +0900
Subject: [PATCH 6/8] ASoC: fsl_esai: fix struct clk pointer comparing
In-Reply-To: <1424876018-17852-7-git-send-email-shawn.guo@linaro.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20150226023641.GI6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:53:36PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/a789c434/attachment.sig>
