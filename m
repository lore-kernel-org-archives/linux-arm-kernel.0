From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Sep 2015 13:35:08 -0700
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <20150918202718.GH8020@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
 <20150918174836.GG8020@atomide.com>
 <20150918202718.GH8020@atomide.com>
Message-ID: <20150918203508.GI8020@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150918 13:27]:

> And also.. It seems wl18xx somehow keeps looing for a wrong

Sorry sent the email before finishing it :) Note related to
these patches, but the wl18xx keeps looking for wrong firmware
and produces the following:

# modprobe wlcore_sdio
...
wlcore: ERROR configuration binary file size is wrong, expected 1229 got 1221
wlcore: WARNING falling back to default config
wlcore: wl18xx HW: 183x or 180x, PG 2.0 (ROM 0x9)
wlcore: loaded

So that's yet another bug to fix somewhere.

Regards,

Tony
