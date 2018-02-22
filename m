From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Feb 2018 17:47:17 +0100
Subject: [GIT PULL 1/2] Rockchip dts32 fixes for 4.16
In-Reply-To: <2137280.MWbT8y5lbZ@phil>
References: <2137280.MWbT8y5lbZ@phil>
Message-ID: <CAK8P3a3nDL01+AX=Kf6s2mdOZq2c1=Jh1VDQizEZNfzJkihbVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 18, 2018 at 4:40 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>
>   ARM: dts: rockchip: Fix DWMMC clocks (2018-02-16 10:45:16 +0100)
>
> ----------------------------------------------------------------
> Fix wrong dwmmc tuning clocks that may make probing HS cards fail to
> probe and removal of special opps from the phycore boards that may
> run the cpu outside the soc-vendor specs.

Pulled into fixes, thanks!

      Arnd
