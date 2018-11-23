From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Nov 2018 11:36:07 +0900
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
In-Reply-To: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
References: <20181115190538.17016-1-hch@lst.de>
 <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 11:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
>
> On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > currently every architecture that wants to provide on of the common
> > periphal busses needs to add some boilerplate code and include the
> > right Kconfig files.   This series instead just selects the presence
> > (when needed) and then handles everything in the bus-specific
> > Kconfig file under drivers/.
>
>
> Thanks for this work!
>
>
> I applied this series, and it is available at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig2


BTW, if you find questionable parts,
please let me know.

We still have plenty of time by the next MW.

Thanks.



-- 
Best Regards
Masahiro Yamada
