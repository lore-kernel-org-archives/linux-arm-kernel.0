From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 14 Aug 2013 16:30:55 +0900
Subject: [GIT PULL] Samsung PWM support cleanup
In-Reply-To: <CAOesGMhUncZmuuptZ3dU4UjVmvjKNb+GJqhwNwvYuUM=R3LwqA@mail.gmail.com>
References: <3516906.8u5IrARqm7@flatron>
 <20130814060702.GH16635@quad.lixom.net> <109a01ce98bd$1843cae0$48cb60a0$@org>
 <CAOesGMhUncZmuuptZ3dU4UjVmvjKNb+GJqhwNwvYuUM=R3LwqA@mail.gmail.com>
Message-ID: <10a701ce98c0$36afd980$a40f8c80$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Wed, Aug 14, 2013 at 12:08 AM, Kukjin Kim <kgene@kernel.org> wrote:
> > Olof Johansson wrote:
> >>
> >> On Tue, Aug 13, 2013 at 11:16:35PM +0200, Tomasz Figa wrote:
> >> > Dear ARM SoC maintainers,
> >> >
> >> > The following changes since commit
> >> > c095ba7224d8edc71dcef0d655911399a8bd4a3f:
> >> >
> >> >   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   git://github.com/tom3q/linux.git tags/v3.12-pwm-cleanup-for-olof
> >>
> >> Thanks, applied.
> >>
> > Same here, this will be merged into samsung tree because of dependency.
> 
> What's the dependency? If it's just two patches (which I think it is),
> just send me your acks on them and we can apply them on top instead.
> 
Yeah if there are two patches, I can. But there are another dependent series
such as "[PATCH v2 0/8] Common Clock Framework support for Samsung S3C64xx"
from Tomasz. So I'd like to merge that into the samsung tree.

- Kukjin
