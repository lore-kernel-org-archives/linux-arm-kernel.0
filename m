From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 30 Jun 2015 08:20:59 +0200
Subject: [PATCH] phy: phy-mxs-usb: suspend to RAM causes NULL pointer
 dereference
In-Reply-To: <20150630061005.GD32758@saruman.tx.rr.com>
References: <1434343020-29604-1-git-send-email-stefan.wahren@i2se.com>
 <5592297B.4080103@i2se.com> <20150630061005.GD32758@saruman.tx.rr.com>
Message-ID: <5592354B.9090406@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.06.2015 um 08:10 schrieb Felipe Balbi:
> On Tue, Jun 30, 2015 at 07:30:35AM +0200, Stefan Wahren wrote:
>> Am 15.06.2015 um 06:37 schrieb Stefan Wahren:
>>> Triggering suspend to RAM via sysfs on a i.MX28 causes a NULL pointer
>>> dereference. This patch avoids the oops in mxs_phy_get_vbus_status()
>>> by aborting since there is no syscon available.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> Fixes: efdbd3a5d6e ("usb: phy: mxs: do not set PWD.RXPWD1PT1 for low speed connection")
>>> CC: <stable@vger.kernel.org> # 4.0
>>> Acked-by: Peter Chen <peter.chen@freescale.com>
>> Just a gentle ping
> it's in my queue, but -rc1 wasn't tagged yet, was it ? In a hurry for
> some reason ?
>

Everything is fine. Sorry for the noise.

Stefan
