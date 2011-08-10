From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 10 Aug 2011 11:04:14 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Set DS1WM clock_rate
In-Reply-To: <CAMPhdO_xL_sUui-22p27oAw52YHnBhm90cn12t5eJsdRLnUfNA@mail.gmail.com>
Message-ID: <1312970654.10843.YahooMailClassic@web29012.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Or this parent driver can silently pass the clock_rate to
> ds1wm sub-driver
> without the if () condition, as it leaves to the sub-driver
> to decide whether
> it's a valid value, unless you want to use 'clock_rate' to
> explicitly control
> the registration of the sub-device.

I followed the example of the pxa/magician + mfd/htc-pasic3 platform.

Regards,
Paul
