From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 12:49:25 +0000
Subject: [PATCH v2 16/17] ASoC: fsl: add dt support for imx-audmux
In-Reply-To: <1330957865-19085-17-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-17-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120306124925.GR19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:31:04PM +0800, Shawn Guo wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> It adds device tree probe support for imx-audmux driver.

Applied this one as well, thanks.  This really should've been in with
all the other audmux motion stuff, there's no dependency on it having
been moved into the fsl directory so it just makes it harder to apply
(but as it was a straight move git am figured it out).

As a general rule put bugfixes first, then minor cleanups, then things
that are internal to existing files (like this) and finally anything
invasive.  Basically, do the urgent stuff first and then work up in
terms of how big/tricky the changes are.  This makes it easier to get
things applied which is especially important with a large series like
this as it makes review easier and means you have fewer out of tree
patches to keep track of.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/62ce2ae8/attachment.sig>
