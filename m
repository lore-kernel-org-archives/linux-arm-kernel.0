From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Dec 2013 21:32:29 +0100
Subject: [PATCH] ARM: dts: stmpe-ts: fix wrong bindings
In-Reply-To: <1386620111-1413-1-git-send-email-stefan@agner.ch>
References: <1386620111-1413-1-git-send-email-stefan@agner.ch>
Message-ID: <201312092132.29575.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 09, 2013 at 09:15:11 PM, Stefan Agner wrote:
> Fix bindings for STMPE touchscreen device to match the documented
> bindings and the actual bindings used by the driver.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> I don't have any of these hardware, but the error is obvious. The device
> probably works anyway since the device/driver will use default values.

Full agreement here.

Reviewed-by: Marek Vasut <marex@denx.de>

btw. I plan to rework the STMPE TS as it doesn't work nicely on my device at 
all. I am seriously lacking time, but I will try! ;-)

Best regards,
Marek Vasut
