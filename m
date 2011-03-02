From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2011 15:46:53 -0000
Subject: [patch v2 2/3] arm: pmu: allow platform specifc irq
	enable/disable handling
In-Reply-To: <AANLkTinbZjNHGiY5Ge-CjHpx9MOxpiELhzmricPEsU=o@mail.gmail.com>
References: <1299063420-22203-1-git-send-email-tom.leiming@gmail.com>	<1299063420-22203-3-git-send-email-tom.leiming@gmail.com>	<-3190832915456449126@unknownmsgid>
	<AANLkTinbZjNHGiY5Ge-CjHpx9MOxpiELhzmricPEsU=o@mail.gmail.com>
Message-ID: <001501cbd8f1$0de23e80$29a6bb80$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Will,

Hello,

> 2011/3/2 Will Deacon <will.deacon@arm.com>:
> > Looks good to me. Unfortunately, I don't have an OMAP4 to test this
> > on (contributions welcome :) so I've just eyeballed the code:
> >
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> >
> > You'll need to wait for the ux500 stuff to be merged before you can
> > get this upstream (Linus W is handling the pull request afaik).
> 
> Thanks for your review, the ux500 stuff has been merged into -next
> tree already, so this one may be into -next too.

Ok, that's great. I've just noticed that you've typoed the subject
line for the patch (s/specifc/specific/) so you might want to fix
that before Sergei spots it!

Will
