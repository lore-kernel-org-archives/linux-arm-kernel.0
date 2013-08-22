From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 10:48:15 +0100
Subject: [PATCH v7 3/7] gpio: samsung: Skip initialization if device tree
 is present
In-Reply-To: <3452017.UPhKO6xNO5@flatron>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-4-git-send-email-tomasz.figa@gmail.com>
 <CACRpkda2ZjPm4nEeDujPWSDCNLk4mr9izPvhqNKx5urVAg_Azg@mail.gmail.com>
 <3452017.UPhKO6xNO5@flatron>
Message-ID: <20130822094815.GP26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 10:06:46AM +0200, Tomasz Figa wrote:
> On Thursday 22 of August 2013 01:21:25 Linus Walleij wrote:

> > This seems like something I should apply to the GPIO tree
> > right now, shall I?

> Would be nice, but since this patch is a dependency for rest of this 
> series and there are no other dependencies on GPIO tree, it might be 
> easier to just let Kukjin take all the patches with required Acks.

Though if the rest of the series might miss v3.12 (seems likely given
the arm-soc deadlines have passed) then Linus could apply this for
v3.12?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/03637f11/attachment-0001.sig>
