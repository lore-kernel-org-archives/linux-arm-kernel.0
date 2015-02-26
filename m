From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Feb 2015 10:20:00 +0800
Subject: [PATCH 7/8] ASoC: fsl_spdif: fix struct clk pointer comparing
In-Reply-To: <20150226021250.GA6236@finisterre.sirena.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-8-git-send-email-shawn.guo@linaro.org>
 <20150226021250.GA6236@finisterre.sirena.org.uk>
Message-ID: <20150226021958.GD20028@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 11:12:50AM +0900, Mark Brown wrote:
> On Wed, Feb 25, 2015 at 10:53:37PM +0800, Shawn Guo wrote:
> > Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> > instances"), clk API users can no longer check if two struct clk
> > pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> 
> Applied, thanks.

Mark,

Sorry that I did not make it clear in the cover-letter.  But the first
patch introduces a helper function clk_is_match(), on which all the
other patches in the series depend.  That said, the patch series should
probably be handled by Mike as a whole.

Shawn
