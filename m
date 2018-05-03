From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 3 May 2018 22:09:08 +0200
Subject: [PATCH 44/61] rtc: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
Message-ID: <20180503200908.GA10960@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/2018 16:06:14+0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/rtc/rtc-bq4802.c   |  6 ++----
>  drivers/rtc/rtc-ds1216.c   |  6 ++----
>  drivers/rtc/rtc-ds1511.c   |  9 +++------
>  drivers/rtc/rtc-ds1553.c   | 15 +++++----------
>  drivers/rtc/rtc-ds1685.c   | 21 +++++++--------------
>  drivers/rtc/rtc-ds1742.c   |  6 ++----
>  drivers/rtc/rtc-lpc32xx.c  | 16 ++++++----------
>  drivers/rtc/rtc-m48t59.c   | 41 ++++++++++++++++-------------------------
>  drivers/rtc/rtc-mv.c       |  3 +--
>  drivers/rtc/rtc-mxc.c      | 21 +++++++--------------
>  drivers/rtc/rtc-pcap.c     | 15 +++++----------
>  drivers/rtc/rtc-sh.c       | 15 +++++----------
>  drivers/rtc/rtc-stk17ta8.c | 15 +++++----------
>  drivers/rtc/rtc-test.c     |  3 +--
>  drivers/rtc/rtc-zynqmp.c   | 10 ++++------
>  15 files changed, 71 insertions(+), 131 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
