From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 30 Jul 2017 21:26:15 +0300
Subject: [PATCH 5/6] drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
In-Reply-To: <1501355870-13960-6-git-send-email-david@lechnology.com>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-6-git-send-email-david@lechnology.com>
Message-ID: <CAHp75VdEcsdnhzi9PX6ziDTbp3KWNtyCZdBseYZ8_yNzus0-ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> LEGO MINDSTORMS EV3 has an LCD with a ST7586 controller. This adds a new
> module for the ST7586 controller with parameters for the EV3 LCD dispay.

>  .../devicetree/bindings/display/mipi-panel.txt     |  2 +-
>  drivers/gpu/drm/tinydrm/mipi-panel.c               | 87 ++++++++++++++++++++++\]

C'mon, changes here have nothing to do with the framework itself!

Header, OTOH, has been looking fine.

-- 
With Best Regards,
Andy Shevchenko
