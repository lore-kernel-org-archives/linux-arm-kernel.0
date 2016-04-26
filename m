From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 11:13:18 -0700
Subject: [PATCH 0/3] AM57/DRA7 Clock Tree DTSI Fix-ups
In-Reply-To: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Message-ID: <20160426181318.GM5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* J.D. Schroeder <Linux.HWI@garmin.com> [160426 10:57]:
> This series of patches fixes several discrepancies between the
> AM57/DRA7 clock tree description and the actual hardware behavior and
> frequencies. With these changes a more complete picture of the clock
> tree is represented for a few of the clocks and their resulting
> frequencies.

Are any of these needed for the v4.6-rc cycle?

Adding Tero to Cc so he can review the changes.

Regards,

Tony
