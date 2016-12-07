From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Dec 2016 00:25:45 +0100
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <CAOesGMh5=R18+wfM5WjUPnQ2a7UFi35t11cRDyTwCYHxpySnMg@mail.gmail.com>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <5275588.dlJdb2OzJi@wuerfel>
 <CAOesGMh5=R18+wfM5WjUPnQ2a7UFi35t11cRDyTwCYHxpySnMg@mail.gmail.com>
Message-ID: <2961489.ldUdBv6eDi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 7, 2016 2:12:23 PM CET Olof Johansson wrote:
> > I checked the other branches now and found two other commits missing
> > in next/fixes-non-critical:
> >
> >
> > arm64: tegra: Add missing Smaug revision
> > arm64: tegra: Add VDD_GPU regulator to Jetson TX1
> >
> > Both sent by Thierry Reding last Friday. I can add them back on top
> > or you pick them up again if you are already busy doing merges.
> >
> > For the first patch, I had amended the changelog text, this is the
> > version I had.
> 
> I'm done touching the tree for today so you can rebase and push your
> versions if you want -- probably easiest all around.
> 

Done.

	Arnd
