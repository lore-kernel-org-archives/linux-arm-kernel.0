From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Sep 2016 01:58:26 +0100
Subject: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160905192404.13871-1-dannym@scratchpost.org>
References: <20160905192404.13871-1-dannym@scratchpost.org>
Message-ID: <20160906005826.GC3950@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 09:24:03PM +0200, Danny Milosavljevic wrote:
> Here's just the part that allows distinguishing sun4i from sun7i.
> 
> Since I'm waiting for Chen-Yu's DAPM_DOUBLE patch series I figured I'd post the preliminaries in the mean time which will not change and can be applied independently without problems.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that 
any important information is recorded in the changelog rather than being
lost. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/1f6b74fd/attachment-0001.sig>
