From: jic23@kernel.org (Jonathan Cameron)
Date: Wed, 17 Jul 2013 20:04:02 +0100
Subject: [PATCH 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
In-Reply-To: <51E668B4.1010000@ti.com>
References: <1373974023-23521-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1373974023-23521-3-git-send-email-oleksandr.kozaruk@ti.com>
 <c8f86766-822b-4fe3-ae2a-e0b12412ef39@email.android.com>
 <51E668B4.1010000@ti.com>
Message-ID: <7725cc73-4cab-49f5-9c33-ef3b24a7ee57@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Oleksandr Kozaruk <oleksandr.kozaruk@ti.com> wrote:
>Hello Jonathan,
>
> >Two very quick comments based on quick glance as it may be a while 
>before I can do a full review.
>
> >We still have channels that are only usable for temperature being 
>output to user space as voltage channels? Is the conversion so very
>hard?
>
>Can you please clarify what should return temperature channel for 
>in_tempX_input (processed)? Is it voltage or Celsius degree?
Milli degrees centigrade.

>in_tempX_raw should return ADC code? Right?
Yes

See Documentation/ABI/testing/sysfs-bus-iio
>
>Regards,
>OK.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
