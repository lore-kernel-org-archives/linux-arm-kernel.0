From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 22 Jun 2015 10:30:38 +1000
Subject: [linux-sunxi] [PATCH 1/4] ARM: dts: sunxi: Add regulator-boot-on
 to usb host port regulator nodes
In-Reply-To: <1434814810-26285-2-git-send-email-hdegoede@redhat.com>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
 <1434814810-26285-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGRGNgU7179K408=PekziP9ZzzG7+rvhm=e7TWjZk1UhkAnVZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sun, Jun 21, 2015 at 1:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> u-boot will have turned on the power to the usb host ports, so mark them
> as regulator-boot-on, this stops the power on the ports from temporarily
> getting turned off during boot, causing issues with e.g. usb powered
> harddisks.

Stupid question: shouldn't u-boot set this property?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
