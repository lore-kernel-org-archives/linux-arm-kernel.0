From: marek.belisko@gmail.com (Belisko Marek)
Date: Fri, 10 Oct 2014 11:28:51 +0200
Subject: [PATCH 0/3] input: tsc2007: Extend for pre-calibration, flipping
 and rotation
In-Reply-To: <1412108254-19234-1-git-send-email-marek@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Message-ID: <CAAfyv36R-qpQPLHGGv8+QPtwyRWRJc4rPi9GcNwWpuCTGmWuWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping. Any objections? Thanks

On Tue, Sep 30, 2014 at 10:17 PM, Marek Belisko <marek@goldelico.com> wrote:
> Following series add support to tsc2007 touchscreen driver for pre-calibration,
> flipping and rotation. Added bindings are documented and used in gta04 device tree.
>
> Marek Belisko (3):
>   input: tsc2007: Add pre-calibration, flipping and rotation
>   Documentation: dt: input: tsc2007: Document new parameters
>   arm: dts: omap3-gta04: Extend touchscreen configs
>
>  .../bindings/input/touchscreen/tsc2007.txt         | 17 ++++-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 |  6 ++
>  drivers/input/touchscreen/tsc2007.c                | 89 +++++++++++++++++++++-
>  include/linux/i2c/tsc2007.h                        |  6 ++
>  4 files changed, 111 insertions(+), 7 deletions(-)
>
> --
> 1.9.3
>

BR,

marek

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
