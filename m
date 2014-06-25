From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 25 Jun 2014 07:10:51 -0700
Subject: [PATCH 2/4 v2] hwmon: ntc_thermistor: Use the manufacturer name
 properly
In-Reply-To: <1403677773-21141-3-git-send-email-ch.naveen@samsung.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
 <1403677773-21141-3-git-send-email-ch.naveen@samsung.com>
Message-ID: <53AAD86B.6080905@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2014 11:29 PM, Naveen Krishna Chatradhi wrote:
> Murata Manufacturing Co., Ltd is the vendor for
> NTC (Negative Temperature coefficient) based Thermistors.
> But, the driver extensively uses "NTC" as the vendor name.
>
> This patch corrects the vendor name also updates the
> compatibility strings according to the vendor-prefix.txt
>
> Note: Drivers continue to support the previous compatible strings
> but further addition of these compatible strings in device tree
> is deprecated.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Applied.

Guenter
