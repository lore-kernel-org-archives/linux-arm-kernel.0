From: Linux.HWI@garmin.com (J.D. Schroeder)
Date: Tue, 26 Apr 2016 12:54:26 -0500
Subject: [PATCH 0/3] AM57/DRA7 Clock Tree DTSI Fix-ups
Message-ID: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches fixes several discrepancies between the
AM57/DRA7 clock tree description and the actual hardware behavior and
frequencies. With these changes a more complete picture of the clock
tree is represented for a few of the clocks and their resulting
frequencies.
