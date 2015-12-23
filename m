From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 23 Dec 2015 11:58:33 +0100
Subject: [PATCH 0/6] LG Optimus Black (P970) codename sniper support and
 lp872x improvements
Message-ID: <1450868319-20513-1-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for the LG Optimus Black, as described in the
patch adding devicetree support for the device.

In order to power the external mmc (mmc1), the lp872x regulator is used.
Its code had to be improved a bit to work on the device.

Note that the patch adding devicetree support for the device requires the
changes applied to the lp872x regulator, so all this is sent in one series
despite the fact they're different parts of the code.
