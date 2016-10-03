From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 3 Oct 2016 17:46:51 +0200
Subject: [PATCH v2] drm: tilcdc: add a da850-specific compatible string
In-Reply-To: <12dad169-de04-ce7d-0422-94c57074c839@ti.com>
References: <1475243564-15765-1-git-send-email-bgolaszewski@baylibre.com>
 <12dad169-de04-ce7d-0422-94c57074c839@ti.com>
Message-ID: <CAMpxmJU2vd+R-HBY7-LcSM02g8XdVqVCs1=cGCj5+jt6ii7ndg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-01 11:30 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Friday 30 September 2016 07:22 PM, Bartosz Golaszewski wrote:
>> Due to some potential tweaks for the da850 LCDC (for example: the
>> required memory bandwith settings) we need a separate compatible
>> for the IP present on the da850 boards.
>>
>
> This documentation does not help much :( It should be on the lines of:
>
> compatible: value should be "ti,am33xx-tilcdc" for AM335x based boards
>             value should be "ti,da850-tilcdc" for DA850/AM18x/OMAP-L138
>             based boards
>
> There are many existing examples of the way compatible strings are
> documented. You can take a look at them too. Also, since you are
> introducing a new device-tree compatible, please keep the devicetree
> list and maintainers in CC too. I don't think it shows up in
> get_maintainer.pl, so you will have to remember to do it.
>

Hi Sekhar,

sorry for that, hope v3 is good.

Thanks,
Bartosz
