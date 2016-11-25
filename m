From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Nov 2016 00:47:37 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.10 (#1)
In-Reply-To: <8760njamyn.fsf@free-electrons.com>
References: <8760njamyn.fsf@free-electrons.com>
Message-ID: <5191100.C2cLkAt6AU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, November 19, 2016 9:33:04 AM CET Gregory CLEMENT wrote:
> Here is the first pull request for dt for mvebu for v4.10. It repalces
> the previous one sent 2 days ago as requested by Olof.
> 
> I take the opportunity to add new commits:
> "ARM: dts: kirkwood: fix spelling mistake" which as applied recently but
> which is harmless and trivial.
> 
> I also add all the non controversial patches removing the DTC
> warning. They wre posted two weeks ago and was in linux-next since this
> day. As there is still some discussions about MBUS_ID and ranges, I will
> prepare a new series for them which I still hope mnage to be part of
> 4.10.
> 

Pulled into next/dt, thanks for the respin!

	Arnd
