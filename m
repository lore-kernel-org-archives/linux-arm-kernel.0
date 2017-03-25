From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 25 Mar 2017 12:03:44 +0100 (CET)
Subject: [GIT PULL 1/4] bcm2835 arm DT updates for 4.12
In-Reply-To: <CAK8P3a2X0LYeidiPw4xN07WdU86Ah3_nJeropNSieJWxsHoEmA@mail.gmail.com>
References: <20170321193952.10270-1-eric@anholt.net>
 <CAK8P3a2X0LYeidiPw4xN07WdU86Ah3_nJeropNSieJWxsHoEmA@mail.gmail.com>
Message-ID: <1533334801.217079.1490439824805@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

i hope it's okay if i answer.

> Arnd Bergmann <arnd@arndb.de> hat am 24. M?rz 2017 um 23:25 geschrieben:
> 
> 
> On Tue, Mar 21, 2017 at 8:39 PM, Eric Anholt <eric@anholt.net> wrote:
> >   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> >
> > are available in the git repository at:
> >
> >   git://github.com/anholt/linux tags/bcm2835-dt-next-2017-03-21
> >
> > for you to fetch changes up to 7f31a955a0c34de0463f7ff50b2bd62a5cce4204:
> >
> >   ARM: dts: bcm2835: add sdhost controller to devicetree (2017-03-17 17:35:50 -0700)
> >
> > ----------------------------------------------------------------
> > This pull request brings in the DT nodes for enabling HDMI audio on
> > Raspberry Pi, and nodes to describe the DSI and SDHOST hardware
> > modules (which are still disabled by default).
> 
> Just a quick question: how do you plan to switch between the SD host
> drivers? If I understand this right, there are two working hardware blocks
> that can connect to the same slot. Do you have to configure this in
> device tree using  hardwired pinctrl settings, or can the user pick
> one of the drivers at runtime?

via device tree

The relevant changes [1] hasn't been merged yet.

[1] - http://marc.info/?l=linux-mmc&m=148896494931931&w=2

> 
>         Arnd
