From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Oct 2016 18:57:47 +0100
Subject: [PATCH] ASoC: samsung: Drop AC97 drivers
In-Reply-To: <1477671072-742-1-git-send-email-s.nawrocki@samsung.com>
References: <1477671072-742-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161028175747.zmurlr6xhyoxc2l5@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 06:11:12PM +0200, Sylwester Nawrocki wrote:
> The AC97 drivers are broken and it seems these have not been used
> for a long time.  This patch removes the unused code, i.e. Samsung
> SoC AC97 controller driver and related machine drivers:
> ln2440sbc_alc650, smdk2443_wm9710, smdk_wm9713.

This needs rebasing against some of the recent fixes, sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161028/cddf7f0f/attachment.sig>
