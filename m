From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 07 Nov 2017 08:21:05 +0100
Subject: [PATCH 0/2] ARM: pxa: move pxa-i2c.h to platform_data
In-Reply-To: <20171105141226.13624-1-wsa@the-dreams.de> (Wolfram Sang's
 message of "Sun, 5 Nov 2017 15:12:24 +0100")
References: <20171105141226.13624-1-wsa@the-dreams.de>
Message-ID: <87efpa8sgu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

> As discussed previously, we move the declarations now to devices.h and the
> platform_data to the platform_data directory. Only build tested, but buildbot
> is happy.
>
> Wolfram Sang (2):
>   ARM: pxa: move declarations to proper place
>   ARM: pxa: move header file out of I2C realm

Hi Wolfram,

This serie looks nice to me.
I'll throw it at my testbench today for a safety check and to see the bissection
is all right.

Meanwhile you can safely prepare your v2.

Cheers.

--
Robert
