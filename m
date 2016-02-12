From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Feb 2016 21:26:00 +0000
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160212212600.GA18872@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 09:30:17AM -0800, Stephen Boyd wrote:
> This reverts commit 18560a4e3b07438113b50589e78532d95f907029.
> 
> The commit that caused us to specify LE device endianness here,
> 29bb45f25ff3 (regmap-mmio: Use native endianness for read/write,
> 2015-10-29), has been reverted in mainline so now when we specify

So, I applied this to -next as that's where it applies but it seems that
you're trying to revert a commit that's in Linus' tree so should go as a
fix to him.  Can you send a fix against Linus' tree too please?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/80d4ba8b/attachment.sig>
