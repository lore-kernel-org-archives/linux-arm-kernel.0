From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Sep 2018 17:30:21 +0200
Subject: [PATCH] [v2] ARM: omap1: add nand_chip declaration
In-Reply-To: <20180926165240.77a78fc4@xps13>
References: <20180926142029.619397-1-arnd@arndb.de>
 <20180926165240.77a78fc4@xps13>
Message-ID: <CAK8P3a29=N9AoBAfKzNR-8fKQgoLGyPJJrqXn0eMwas+nKWN=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 4:52 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:
> > @@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
> >
> >  extern void __init omap_check_revision(void);
> >
> > +struct nand_chip;
> >  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
> >                              unsigned int ctrl);
> >
>
> Boris pointed me that the commit introducing the regression is still
> in nand/next, so do you mind if I squash both patches with it?

No worries, please do that if it makes it easier for you.

      Arnd
