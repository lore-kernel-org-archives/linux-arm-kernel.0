From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Feb 2016 22:25:56 +0000
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <20160212220454.GF4847@codeaurora.org>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
 <20160212212600.GA18872@sirena.org.uk>
 <20160212220454.GF4847@codeaurora.org>
Message-ID: <20160212222556.GC18988@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 02:04:54PM -0800, Stephen Boyd wrote:
> On 02/12, Mark Brown wrote:

> > So, I applied this to -next as that's where it applies but it seems that
> > you're trying to revert a commit that's in Linus' tree so should go as a
> > fix to him.  Can you send a fix against Linus' tree too please?

> Did you want me to send the fix directly to Linus? The patch
> applies to both -next and Linus' tree, although you're right I
> generated this patch against -next. If I apply it to Linus' tree
> and then git format-patch it's exactly the same except for the
> commit hash:

No, of course not!  Send it to me.  What I'm looking for is something
that I can apply - it doesn't apply to my current Qualcomm fixes branch.  
Looking again I see that the issue is that that branch is based on
v4.4, I pulled it over now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/24f8e8a8/attachment.sig>
