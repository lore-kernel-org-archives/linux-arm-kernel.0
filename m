From: ccross@android.com (Colin Cross)
Date: Tue, 22 Feb 2011 11:59:49 -0800
Subject: [PATCH v2] i2c: tegra: Add i2c support
In-Reply-To: <1298250861-27094-1-git-send-email-ccross@android.com>
References: <AANLkTim0X=gUwYJmR+EAYjGamiJb7tgiVEjwqCEF0-L0@mail.gmail.com>
	<1298250861-27094-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTim1obQs6m7w4m+iCdZKfv6W=frFAcN_kTmi9=vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 5:14 PM, Colin Cross <ccross@android.com> wrote:
> Adds I2C bus driver for nVidia Tegra SoCs. ?Tegra includes 4 I2C
> controllers, one of which is inside the Dynamic Voltage Controller
> and has a slightly different register map.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Ping?  Can this go in 2.6.39?
