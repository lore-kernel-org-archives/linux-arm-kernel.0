From: rob@emanuele.us (Robert Emanuele)
Date: Wed, 26 May 2010 12:08:26 -0700
Subject: Controlling Driver Load Order
Message-ID: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

Hopefully this is an easy question but I haven't found a solution yet.

On my at91sam9g45 platform I need my i2c drivers to load before the
framebuffer driver.  The i2c drivers control a power management IC
which is needed to enable the graphics controller.

Is there a way to set up that order?

Thank you,

Rob Emanuele
