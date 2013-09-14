From: olof@lixom.net (Olof Johansson)
Date: Fri, 13 Sep 2013 22:10:17 -0700
Subject: [PATCH 0/2] WLAN regression fixes for omap4 after moving to DT
 based booting
In-Reply-To: <20130913190811.24617.97699.stgit@localhost>
References: <20130913190811.24617.97699.stgit@localhost>
Message-ID: <CAOesGMgzMfxoJpEOXhs8dQrpqavpWxG6_RfXHMEpDnEnOrP7iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Not related to wlan but with DT conversion; I noticed the following in
dmesg on Panda ES with omap2plus_defconfig on current mainline:

[    0.000000] smp_twd: clock not found -2

and:

[    0.440399] omap-gpmc 50000000.gpmc: error: clk_get


-Olof
