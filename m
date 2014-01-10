From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Fri, 10 Jan 2014 12:46:49 +0100
Subject: imx-drm and pwm-backlight
In-Reply-To: <CAH9NwWeCQWKdCWGFkn4kYym0znF+Z3-TNUAVkVCaj4U_tV4-Aw@mail.gmail.com>
References: <CAH9NwWeCQWKdCWGFkn4kYym0znF+Z3-TNUAVkVCaj4U_tV4-Aw@mail.gmail.com>
Message-ID: <CAH9NwWetYCXPRUZMNdgc_thZge2vNYRGiv19NvmebB-0+PWasg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

2014/1/7 Christian Gmeiner <christian.gmeiner@gmail.com>:
> Hi all.
>
> I am working on a product based on the imx6 where a display is
> connected via ldb.
> There are two gpio pins which are used to control the LCD_ON and the
> BACKLIGHT_ON
> of the used display.
>
> Now I run into two issues:
>
> 1) The backlight gets turned on before the imx-drm driver is loaded/ready.
> For a fraction of a second the last or random framebuffer content gets shown.
>
> 2) If the backlight gets turned off and on the shown picture flickers
> for some seconds
> until it gets back to normal. I have talked to the display vendor and they told
> me that I need to use the correct timings for LCD_ON etc.
>
> Do I need to use a regulator to archive this?
>
> thanks
> --
> Christian Gmeiner, MSc


--
Christian Gmeiner, MSc
