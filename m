From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 11:56:01 +0300
Subject: [PATCH 00/28] crypto: omap fixes / support additions
Message-ID: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for crypto hardware accelerators on TI DRA7xx
and AM43xx SoCs, and fixes a number of bugs in the existing codebase.
This series also addresses performance issues with the AES / SHA
accelerators, doing some optimizations on these.

Patch #7 and #13 are generic crypto API implementation changes.
Without #7, omap-sham export/import does not work, #13 is kind
of nice to have.

Patches 16+ should be picked-up / acked by Tony, but they have
dependencies on the preceding patches; at least the AES dual core
support must be in before applying the rest, otherwise bad things
will happen.

-Tero
