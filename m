From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Feb 2015 11:29:44 +0900
Subject: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
In-Reply-To: <20150226021958.GD20028@dragon>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
 <20150226021250.GA6236@finisterre.sirena.org.uk>
 <20150226021958.GD20028@dragon>
Message-ID: <20150226022944.GD6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 10:20:00AM +0800, Shawn Guo wrote:

> Sorry that I did not make it clear in the cover-letter.  But the first
> patch introduces a helper function clk_is_match(), on which all the
> other patches in the series depend.  That said, the patch series should
> probably be handled by Mike as a whole.

Ugh, right.  I've dropped those patches then.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/0cf9f199/attachment.sig>
