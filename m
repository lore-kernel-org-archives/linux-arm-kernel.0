From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 03 Sep 2015 21:03:15 +0200
Subject: [PATCH v2 0/2] ARM: dts: rockchip: pull up cts lines
In-Reply-To: <1441236479-4941-1-git-send-email-amstan@chromium.org>
References: <1441236479-4941-1-git-send-email-amstan@chromium.org>
Message-ID: <2685164.GZh6IdR1jF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

Am Mittwoch, 2. September 2015, 16:27:57 schrieb Alexandru M Stan:
> The flow control lines from a user accessible UART are optional,
> the user might not have anything connected to those pins.
> In order to prevent random interrupts happening and noise affecting
> the cts pin should be pulled up.
> 
> The only boards affected (that care about uart*_cts ) are the veyron
> chromeos devices and the firefly. Veyron already has something like that,
> which I now have to remove in the second patch. Firefly uses uart0_cts
> for the wifi chip communications, same thing as veyron, so it should be
> fine having it.

applied both to my dts branch for 4.4 with Doug's Review-tag
(Currently only on github and becomes really public after 4.3-rc1)


Heiko
