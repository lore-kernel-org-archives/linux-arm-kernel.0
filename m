From: phh@phh.me (Pierre-Hugues Husson)
Date: Sat, 14 Oct 2017 15:14:40 +0200
Subject: [PATCH 0/3] Enable CEC on rk3399
In-Reply-To: <9833f103-769f-b9b9-05c7-4d75bd7e487c@xs4all.nl>
References: <20171013225337.5196-1-phh@phh.me>
 <9833f103-769f-b9b9-05c7-4d75bd7e487c@xs4all.nl>
Message-ID: <CAJ-oXjQ3e1UHVGq=uV=yAK9Bu=ZoiNZaEbnHyvNtyc15RQQSKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

> Nice! I had a similar dw-hdmi.c patch pending but got around to posting it.
>
> I'll brush off my old rk3288 patches and see if I can get CEC enabled
> for my firefly-reload. I was close to getting it work, but I guess
> missed the "enable cec pin" change.
Please note that on rk3288, there are two CEC pins, and you must write
in RK3288_GRF_SOC_CON8 which pin you're using.
On the firefly-reload, the pin used is GPIO7C0, while the default pin
configuration is GPIO7C7.

Regards,
