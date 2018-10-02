From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 11:46:24 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.20 (#1)
In-Reply-To: <87pnwungjn.fsf@bootlin.com>
References: <87pnwungjn.fsf@bootlin.com>
Message-ID: <CAK8P3a3bxJgyCo6VjsSGSuObBqdcnHU58FY27giXgQmK8nMQ+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 11:48 AM Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>
> ----------------------------------------------------------------
> mvebu dt for 4.20 (part 1)
>
> - updates the armada-xp-98dx3236 SoC and related boards to use the new
>   style dts bindings for nand
>
> - add db-88f6820-amc board: plugin card for some of Marvell's switch
>   development kits
>
> - fix SPI and I2C bus warnings coming with the new checks in dtc
>
> - add new compatible string "marvell,prestera" to the armada-xp-98dx*
>
> - fix sdhci supply property name on the clearfog (the '-supply' suffix
>   was missing)

Pulled into next/dt, thanks!

    Arnd
