From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 18 Jul 2016 20:12:32 +0200
Subject: [PATCH v3] arm64: dts: rockchip: Add basic support for orion-r68
In-Reply-To: <1468577391-5096-1-git-send-email-matthias.bgg@gmail.com>
References: <1468577391-5096-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <5040831.O6sNvccABs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Juli 2016, 12:09:51 schrieb Matthias Brugger:
> This patch adds basic support for the Tronsmart orion r86 set-top-box.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

applied [0] with Rob's Ack.

I've removed the duplicate mmc cap and also reordered properties to be 
alphabetically sorted, please double check.

While it is in my 4.8 dts branch, this will only make it into 4.9 though.


Heiko
