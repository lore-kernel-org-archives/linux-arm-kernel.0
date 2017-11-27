From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 11:35:00 -0200
Subject: [PATCH] ARM: dts: imx53-cx9020: Fix the Ethernet PHY reset GPIO
 polarity
In-Reply-To: <20171127132903.GD19413@lunn.ch>
References: <1511650267-21933-1-git-send-email-festevam@gmail.com>
 <20171127132903.GD19413@lunn.ch>
Message-ID: <CAOMZO5DYY4vuHXRsce1gaQ2mjkfa3=E12k-ySfkN7yTjEp0wqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Nov 27, 2017 at 11:29 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> Hi Fabio
>
> Do you have a bigger plan than just 'documentation'. Given that device
> tree is an ABI, the GPIO_ACTIVE_ flag has to be ignored. Having it
> correct is just documentation.
>
> If you want to fix them all, is it worth adding in a warning to detect
> a miss match between the GPIO_ACTIVE_* and phy-reset-active-high?

This was the only dts with a mismatch.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks
