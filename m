From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Mar 2010 10:27:59 +0800
Subject: [PATCH 2/4] Driver for Zipit Z2 battery chip
In-Reply-To: <201003101741.17840.marek.vasut@gmail.com>
References: <201003101741.17840.marek.vasut@gmail.com>
Message-ID: <f17812d71003211927p2acd79d6i2a72a9ef0a159032@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 12:41 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Hi,
> This patch adds driver for Zipit Z2 battery chip called AER915. No
> details are known about the chip. The chip is available through I2C bus
> at address 0x55 and it's register 0x02 contains battery voltage.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>

Anton Vorontsov Cc'ed.
