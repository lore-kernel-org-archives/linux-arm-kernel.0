From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 13 Jan 2015 04:03:25 -0800
Subject: [PATCH v4 1/2] watchdog: Add driver for Mediatek watchdog
In-Reply-To: <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
References: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
 <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <54B5098D.9030108@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 07:34 AM, Matthias Brugger wrote:
> This patch adds a driver for the Mediatek SoC integrated
> watchdog. This driver supports watchdog and software reset
> for mt65xx and mt81xx SoCs.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Assuming you fix the missing newline, as pointed out by Joe:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
