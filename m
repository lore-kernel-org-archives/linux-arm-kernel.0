From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 29 Oct 2018 22:01:44 +0900
Subject: [PATCH v2 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
In-Reply-To: <20181028131357.parhzj32feapxncb@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
 <20181028125106.azcn2dxia3snplin@mail.google.com>
 <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
 <20181028131357.parhzj32feapxncb@mail.google.com>
Message-ID: <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


On Sun, Oct 28, 2018 at 10:14 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Sun, Oct 28, 2018 at 10:09:21PM +0900, Masahiro Yamada wrote:
> > Hi Changbin,
> >
> > On Sun, Oct 28, 2018 at 9:52 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > > >
> > > Thanks for pointing this out and kind suggestions. I have tested with your
> > > modification. Will update patch serias soon.
> >
> >
> > I have one more request.
> >
> > The patch subject
> > "kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
> > optimization"
> > is too long (83 characters)
> >
> >
> > I'd like the subject to be within 70 columns or so.
> >
> oh, I just sent new version. Could me update the title if there are more
> suggestions then?



How about this?

2/4: kernel hacking: add a config option to disable compiler auto-inlining
3/4: ARM: mm: fix build error in fix_to_virt with -Og optimization level
4/4: kernel hacking: support building kernel with -Og optimization level

(The CONFIG name is so long that the subject
would easily exceeds 80-columns with it.)


I applied this series to linux-kbuild,
and will send another pull request in this MW.


If you come up with better patch titles,
please let me know.
I will fix them up locally.



-- 
Best Regards
Masahiro Yamada
