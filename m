From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jul 2015 14:52:56 +0100
Subject: [RESEND 09/10] regulator: pwm-regulator: Simplify voltage to
 duty-cycle call
In-Reply-To: <20150707134503.GG3182@x1>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
 <1436173112-21397-10-git-send-email-lee.jones@linaro.org>
 <20150707133245.GM2887@sirena.org.uk> <20150707134503.GG3182@x1>
Message-ID: <20150707135256.GQ2887@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 02:45:03PM +0100, Lee Jones wrote:
> On Tue, 07 Jul 2015, Mark Brown wrote:

> > You just added this function in the previous patch?

> You're right, it does look a little weird contained in a single
> patch-set.  The submission in the previous patch is the tried and
> tested (i.e. in real releases) method written by ST.  This patch
> contains a simplification provided by me.  IMO it looks and performs
> better, but doesn't have the same time-under-test that the original
> method does.  I'm merely ensuring we keep some history in order so
> provide and easy way back i.e. revert.

> If I have any say at all, I'd really like to keep this piece of
> history.

OK, that makes sense - can you put the above in the commit message
please?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150707/17e342f6/attachment.sig>
