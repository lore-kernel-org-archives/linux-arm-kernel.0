From: ppokorny@penguincomputing.com (Phil Pokorny)
Date: Mon, 8 Oct 2012 22:10:58 -0700
Subject: [PATCH] Add McSPI devices found in AM33xx SoC to dtsi
Message-ID: <CAAek22HhtFc-1XOFrQC8DKZ9VdKyuShE_G_j4581WL15JTNJXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're using the BeagleBone for a project and we need the SPI devices
available and configured with all available chip selects.

Please accept the following patch to add these to the base .dtsi file
so they can then be enabled in the beaglebone specific .dts with
minimal fuss.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch
Type: application/octet-stream
Size: 1129 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121008/88a2e9d8/attachment.obj>
