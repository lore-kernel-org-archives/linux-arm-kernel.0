From: marek.belisko@gmail.com (Belisko Marek)
Date: Tue, 31 May 2016 08:48:44 +0200
Subject: [PATCH 0/5] ARM: dts: omap3-gta04: Various updates
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Message-ID: <CAAfyv37NE1eogrSRCuRY-9V30FtD3u7oeFWMJk=xNX1hFJ9O-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping? Any objections? Thanks.

On Tue, May 17, 2016 at 9:48 PM, Marek Belisko <marek@goldelico.com> wrote:
> Add various improvements for gta04 device (wifi, backlight, irq lines for sensors)
>
> H. Nikolaus Schaller (4):
>   ARM: dts: omap3-gta04: Define and use bma180 irq pin
>   ARM: dta: omap3-gta04: Define and use itg3200  irq pin
>   ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
>   ARM: dts: omap3-gat04: Fix wifi handling
>
> Marek Belisko (1):
>   ARM: dts: omap3-gta04: Add backlight support
>
>  arch/arm/boot/dts/omap3-gta04.dtsi | 60 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> --
> 2.5.0
>

Marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
