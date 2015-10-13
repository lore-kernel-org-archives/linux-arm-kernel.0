From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 13 Oct 2015 17:22:22 -0400
Subject: [PATCH 0/5] ARM: dts: add device tree support for NS, NSP,
 and NS2 clocks
Message-ID: <1444771347-11382-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds device tree support for the Broadcom Northstar,
Northstar Plus, and Northstar 2 clocks.  This is being sent as a
separate patch series due to the the clk maintainer(s) not wanting to
pull in device tree changes into the clk repo.  This series is an RFC
due to a potential merge "race" between the device tree changes and the
clk changes.  If the device tree changes go in before the clk changes,
there is a window where there are non-working clk entries in the device
tree.  So, these patches will be officially pushed once the clk changes
are merged.

Thanks,
Jon
