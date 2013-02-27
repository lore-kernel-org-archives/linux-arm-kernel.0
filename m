From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed, 27 Feb 2013 11:41:48 +0100
Subject: [PATCH v2 0/3] crypto: sahara: Add support for SAHARA in i.MX27.
Message-ID: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
this v2 of the series solves several issues pointed out by Arnd Bergmann
and Arnaud Patard.

Moreover, it drops platform support and relies only on device tree (compile
tested only).

[PATCH v2 1/3] i.MX27: Add clock support for SAHARA2.
[PATCH v2 2/3] crypto: sahara: Add driver for SAHARA2 accelerator.
[PATCH v2 3/3] crypto: sahara: Add device tree binding for SAHARA2.
