From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Tue, 09 Feb 2016 15:14:35 -0500
Subject: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
In-Reply-To: <CAJZ5v0jUipo06fpSQsKi+5Po_32ntgc3Ns29=17SgQr2PSj+kA@mail.gmail.com>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAHp75VdWPUZ8F5rsGn3M1e5Pgpcg1CErBej9PE_3+ZPke5CDFA@mail.gmail.com>
 <CAHp75Vf9TS-AxJALQjiwNjMCT8ct5SBanYzrEsV9aj=DsUw-OA@mail.gmail.com>
 <1783906.XctYjeUNLr@vostro.rjw.lan>
 <44858.1454967873@turing-police.cc.vt.edu>
 <CAJZ5v0jUipo06fpSQsKi+5Po_32ntgc3Ns29=17SgQr2PSj+kA@mail.gmail.com>
Message-ID: <43751.1455048875@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Feb 2016 22:50:39 +0100, "Rafael J. Wysocki" said:
> On Mon, Feb 8, 2016 at 10:44 PM,  <Valdis.Kletnieks@vt.edu> wrote:

> > My Dell Latitude laptopi on next-20160201 is throwing a similar error
> > at shutdown, except the traceback continues:
> >
> > mei_me_remove+0xbd/0xc0
> > pci_device_shutdown+0x32/0x50
> > device_shutdown+0xe2/0x210
> >
> > (sorry, that's all I have, transcribing from one frame of video shot while
> > the system was shutting down....)
>
> This should be fixed in 4.5-rc3, so please retest.

Confirming that next-20160201 has the problem, but it is fixed as of next-20160208.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/21dddf40/attachment.sig>
