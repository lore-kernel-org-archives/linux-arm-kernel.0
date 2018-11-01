From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Nov 2018 15:20:32 +0800
Subject: [PATCH 2/7] arm64: allwinner: h6: Add common orangepi nodes into
 dtsi
In-Reply-To: <CAMty3ZCv9z=uALo-PShS-RegNt2cOwOHWE=6vsRVgPm9oOQ_Fw@mail.gmail.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-2-jagan@amarulasolutions.com>
 <CAGb2v66ALW1EL5+buporX8cPjkfpNdwGJEVUrC9Xpcmt3-NX7g@mail.gmail.com>
 <CAMty3ZCv9z=uALo-PShS-RegNt2cOwOHWE=6vsRVgPm9oOQ_Fw@mail.gmail.com>
Message-ID: <CAGb2v66v8akRfTHMCRYUZePwg9f9DdTVrX6G9-OOu1W_Sw6tOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 3:13 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 8:23 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Orangepi H6 boards, One Plus and Lite2 shares common
> > > nodes like axp805, uart, mmc0 etc and the common differences
> > > between them is Ethernet is available in One Plus where
> > > as Wifi, USB3, CSI port is available in Lite2.
> >
> > You can claim this for pretty much all Allwinner boards, because they mostly
> > derive from the reference designs Allwinner's design houses put out. Yet we
> > don't do this for all of them. We do this for boards that are clearly derived
> > or extended from one another. One example would be the Orange Pi PC and PC Plus.
> >
> > Do you have any evidence to suggest so? This is not about common device nodes,
> > but a common hardware design.
>
> I got this information from hardware schematics and from Steven (added
> in to list), he too claimed the same.

Good. Please add that to the commit message. The vendor's intentions are as
important as the actual facts.

ChenYu
