From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 18 Jan 2016 09:41:38 -0800
Subject: [PATCH 0/4] rotary-encoder: use generic device properties
Message-ID: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series tries to move the driver away from legacy platform data towards
using platform-independent way of retrieving both configuration parameters and
GPIOs (device_property_read_* and gpiod APIs).

This is based on top of 2 Timo's patches converting the driver to use devm* API
and threaded IRQs. I uploaded all changes into 'rotary-encoder' branch of my
tree.

I do not have hard ware so please give it a spin, especially on raumfield as it
uses branch new way of passing platform parameters to the driver.

Thanks.

-- 
Dmitry
