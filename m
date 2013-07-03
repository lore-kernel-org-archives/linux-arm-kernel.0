From: coelho@ti.com (Luciano Coelho)
Date: Wed, 3 Jul 2013 16:45:32 +0300
Subject: [PATCH v2 0/9] wilink: add device tree support
In-Reply-To: <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
Message-ID: <1372859132.21065.111.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-03 at 13:13 +0300, Grazvydas Ignotas wrote:
> Hi,

Hi Gra?vydas,


> On Tue, Jul 2, 2013 at 5:55 PM, Luciano Coelho <coelho@ti.com> wrote:
> > Hi,
> >
> > This is a follow-up on a previous patch set that had a smaller
> > audience.  This time, I added the lists and people who were involved
> > in the review of the bindings documentation, since most of my changes
> > in v2 are coming from discussions there.
> >
> > This patch series adds device tree support to the wlcore_sdio driver,
> > which is used by WiLink6, WiLink7 and WiLink8.
> 
> Could you perhaps consider doing device tree conversion for wl1251
> too? With the knowledge you have from working on this series, it would
> be much easier for you to do it than for someone else, and I don't
> have much hope someone will do it at all. It's WiLink series chip
> after all. Without this pandora and N900 are going to lose wifi
> support after the switch to dt-only kernel.

Unfortunately I don't have much time to work on wl1251.  I think it
wouldn't be too difficult to do though, so patches are welcome. ;)

Maybe you could try to make this change and I could support you if
needed?


> I can offer you my help testing things on pandora and I'm sure someone
> here could try it on N900.

I could try it on the N900, if it is still bootable easily with the
mainline. ;)

--
Cheers,
Luca.
