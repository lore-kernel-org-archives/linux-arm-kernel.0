From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 18:41:17 +0000
Subject: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
In-Reply-To: <528A4EBB.2090800@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
 <20131116101422.GK15393@sirena.org.uk>
 <528A4EBB.2090800@wwwdotorg.org>
Message-ID: <20131118184117.GT2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 10:30:35AM -0700, Stephen Warren wrote:

> However, I suspect that the Tegra driver changes may need to be merged
> into any subsystem that's doing much other work on the Tegra drivers,
> especially any significant refactoring, so the subsystem would probably
> have to pick up the whole series anyway. Still, I'll make sure I
> re-order the branch to put the core changes first so we have as much
> flexibility as possible.

At least in the ASoC case my main consideration is other drivers wanting
to use the core changes rather than changes being made to the Tegra
drivers.  Let's try to just share the core code and merge the rest over
later if needed?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/aad32f00/attachment.sig>
