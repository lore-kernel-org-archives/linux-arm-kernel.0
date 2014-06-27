From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Jun 2014 16:35:58 -0300
Subject: HDMI and LVDS on mx6
Message-ID: <CAOMZO5C8n6tZbmoN_M_GB-Aq_1qDRensM7wi1_MSTSxJFFtwUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On mx6qsabresd we have LVDS and HDMI ports and with kernel 3.15 I had
to disconnect/connect the HDMI cable in order to get both displays
working.

I could workaround this by moving the LDB parent to a clock different than pll5.

Now with 3.16-rc1 the situation is even worse:

- Boot the kernel with HDMI cable connected: only LVDS is functional
- Removing the HDMI cable causes LVDS to turn off
- Connect HDMI cable, then LVDS turns on, but still no HDMI

I also tried moving the LDB parent to a clock different than pll5.,
but it does not help in 3.16-rc1.

Any help is appreciated here.

Regards,

Fabio Estevam
