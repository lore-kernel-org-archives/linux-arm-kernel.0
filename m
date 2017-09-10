From: metux@gmx.de (Enrico Weigelt, metux IT consult)
Date: Sun, 10 Sep 2017 18:06:18 +0200
Subject: dtc: imx6 warnings on unit address format errors
Message-ID: <22d62057-c7a0-04d8-3c80-aefb9cbef1b8@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,


I'm getting lots of warnings from dtc about unit address format errors:

For example in imx6q.dtsi:

      ocram: sram at 00900000 {

The node name's address part has leading zeros which dtc doesn't like.
It doesn't seem to have a big influence (yet ?), but I'd guess this
warning is there for a reason.

Should we fix this ?


--mtx
