From: venkataravi.e@techveda.org (venkataravi.e at techveda.org)
Date: Fri,  1 Dec 2017 12:08:27 +0530
Subject: [PATCH 0/4] arm: dts: imx28: imx28-evk device tree cleanup
Message-ID: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ravi Eluri <venkataravi.e@techveda.org>

Removed lot of redundant device tree syntax from imx28-evk device tree
to make it more robust and readable.

Total four changesets and are described as follows:

Changeset 1 removes unit addresses for all peripherals of imx28 in
imx28-evk DT as they are already defined in the corresponding dtsi file.
Make use of phandles reference peripheral nodes in dts files.

Changeset 2 removes unit addresses for the system buses of imx28 as they
are already defined in the corresponding dtsi file.

Changeset 3 rearranges nodes for better readability.

Changeset 4 does DT cleanup (whitespaces, tabs ...)

Note:
- Changesets were compile tested and built(ARCH=arm, imx28) on linux-next 
  (latest).
- No build issues reported.
- Please discard this changesets, if this is not making any better."

Ravi Eluri (4):
  arm: dts: imx28: Use phandles instead of unit addresses
  arm: dts: imx28: Remove system bus unit addresses
  arm: dts: imx28: Rearrange nodes for better readability
  arm: dts: imx28: Device tree cleanup

 arch/arm/boot/dts/imx28-evk.dts | 503 ++++++++++++++++++++--------------------
 1 file changed, 247 insertions(+), 256 deletions(-)

-- 
1.9.1
