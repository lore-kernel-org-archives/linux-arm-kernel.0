From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 21 Feb 2015 13:18:16 -0200
Subject: imxfb does not turn on automatically
Message-ID: <CAOMZO5CZ3aFGbfb39XoXpFvbn4TTrCbTHOXtQKruruCis3Ptvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Carlos Soto uses a Karo mx25 and he noticed that the LCD only works if we do:

echo 1 > /sys/class/graphics/fb0/blank
echo 0 > /sys/class/graphics/fb0/blank

I can confirm the same on mx25pdk running 3.19 [1], but I could not
understand why the display does not start turned on by default.

[1] http://www.spinics.net/lists/arm-kernel/msg399949.html

Any ideas?

Thanks,

Fabio Estevam
