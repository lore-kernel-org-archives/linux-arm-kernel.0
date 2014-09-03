From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Sep 2014 11:49:56 -0700
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <201408241408.19861.arnd@arndb.de>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <1465795.XsPpj3dZHX@wuerfel> <87d2bq43pc.fsf@free.fr>
 <201408241408.19861.arnd@arndb.de>
Message-ID: <20140903184956.11368.47800@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2014-08-24 05:08:19)
> On Sunday 24 August 2014, Robert Jarzmik wrote:
> > > By default, I'd expect Haojian to pick up the patches and send
> > > us a pull request. He sent an Ack, but also didn't make it clear
> > > that we should pick them up.
> > I was thinking that they would go through the clk maintainers, hence Haojian's
> > ack. If they should go through arm-soc, they would need Mike's ack.

Robert,

I'm happy to take the patches but they will need to be rebased onto
clk-next and refactored to take into account Tomeu's api split[0].

> 
> Right, makes sense. We have in the past done it either way for other
> platforms. When merging the patches through the clk subsystem, it still
> makes sense to let us know of those plans and ask for an Ack from
> the arm-soc maintainers, to be sure we can plan ahead in case there
> are other (conflicting) patch sets that are sent through arm-soc.

Arnd,

Do I have your Ack for the arch/arm patches?

[0] https://lkml.kernel.org/r/<1409758148-20104-1-git-send-email-tomeu.vizoso@collabora.com>

Thanks,
Mike

> 
>         Arnd
