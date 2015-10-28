From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 10:46:06 +0900
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <1445971482.2757.27.camel@perches.com>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
Message-ID: <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-28 3:44 GMT+09:00 Joe Perches <joe@perches.com>:
>
> On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
> > On Tue, 27 Oct 2015, Sebastian Reichel wrote:> >
> > > I think you should CC the people, which are changed from "M:" to
> > > "R:", though.
> >
> > Yes, makes sense.
> >
> > I'd like to collect some Maintainer Acks first though.
>
> I think people from organizations like Samsung are actual
> maintainers not reviewers.
>
> Their drivers are not thrown over a wall and forgotten.

At least for Samsung Multifunction PMIC drivers (and some of Maxim
MUICs and PMICs) these are actively used by us in existing and new
products. They are also continuously extended and actually maintained.
This means that it is not only about review of new patches but also
about caring that nothing will become broken.

I would prefer to leave the "SAMSUNG MULTIFUNCTION PMIC DEVICE
DRIVERS" entry as is - maintainers.

Best regards,
Krzysztof
