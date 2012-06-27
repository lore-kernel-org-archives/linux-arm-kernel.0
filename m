From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 14:21:47 +0200
Subject: [PATCH 0/3] usb: chipidea: fix error handling and add dr_role property
Message-ID: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

while hacking on the chipidea driver, I fixed the error path in
the udc part of the chipidea driver. Further I added the possibility
to limit the driver to host or device only mode. It's possible via
platformdata and device tree. For dt I selected the dr_role property
which is already used for other dual role usb drivers.

regards, Marc
