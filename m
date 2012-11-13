From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 14:36:53 +0900
Subject: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
In-Reply-To: <201211122111.03440.arnd@arndb.de>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <201211122111.03440.arnd@arndb.de>
Message-ID: <20121113053651.GB18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 09:11:03PM +0000, Arnd Bergmann wrote:

> * Always let the person that owns the dependency know that the changes in
>   their tree are also included elsewhere and that things go bad if those
>   changes get rebased after all, or won't make it into the merge window
>   for some reason.

Please never pull anything from me unless there's a signed tag for it,
anything else I won't know about and may be rebased or vanish or
something.

> I have taken Mark on Cc to let him know about the dependency now, and I've
> merged ab6f6d85210c4d0265cf48e9958c04e08595055a (which has only shmobile
> specific ASoC patches) into the next/boards2 branch before merging your
> branch. This is still not perfect because it breaks bisection, but it's
> the best I could do aside from forcing you do do another round-trip.

What's the bisection problem?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/9edeb3cc/attachment.sig>
