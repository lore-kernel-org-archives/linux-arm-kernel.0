From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Dec 2013 16:58:53 +0000
Subject: [Patch v2 2/2] ASoC: atmel: sam9x5_wm8731: remove
 platform_set_drvdata
In-Reply-To: <52A59955.8000100@atmel.com>
References: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
 <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
 <52A59955.8000100@atmel.com>
Message-ID: <20131209165853.GS29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 11:20:05AM +0100, Nicolas Ferre wrote:

> It seems that this patch has not been applied to your "next" branch
> (aka ping)...

If you think something has been forgotten please resend.  If it's
genuinely been lost it's going to need resending and the mail just leads
to more mails, a resend can be directly applied.  I had thought I'd
replied to this at the time but it seems I didn't, or at least I can't
see my reply on the list...  sorry about that.

The question was if we should change this or if we should change the
core to not overwrite something that probably ought to be the driver's
domain?  Looking at the code I think we're probably doing the right
thing but it'd be good to consider.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/06881f6f/attachment.sig>
