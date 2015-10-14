From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Oct 2015 15:11:20 +0100
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014134721.GD3816@twins.programming.kicks-ass.net>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014102706.GR14956@sirena.org.uk>
 <20151014110717.GT17308@twins.programming.kicks-ass.net>
 <20151014123624.GV14956@sirena.org.uk>
 <20151014134721.GD3816@twins.programming.kicks-ass.net>
Message-ID: <20151014141120.GX14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 03:47:21PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 14, 2015 at 01:36:24PM +0100, Mark Brown wrote:

> Does the below work for you?

Yes, that's helpful thanks!

Reviewed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/f9e33bbc/attachment.sig>
