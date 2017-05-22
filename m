From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Mon, 22 May 2017 07:41:48 +0200
Subject: [PATCH v4 0/5] iio: ADC driver for EP93xx SoC
In-Reply-To: <5921F894.90809@gmail.com>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
 <df337513-23c7-06b8-50e4-94560e75650c@kernel.org> <5921F894.90809@gmail.com>
Message-ID: <d0adb2f7-8e46-bfa9-b256-daf7f1a3544f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ryan!

On 21/05/17 22:29, Ryan Mallon wrote:
>> How do you want to handle taking this series forward.
>> Clearly we have a few arch specific bits and then the driver which
>> is dependent on some of them.
> I no longer maintain an ep93xx tree because the architecture gets very
> few patches now. Patches should go via the arm-soc tree, which is
> maintained by (I believe) Arnd and Olaf.

This probably should be reflected in MAINTAINERS file?
Do you want to drop EP93xx maintenance?
In this case I can volunteer myself as a maintainer for the platform.

--
Best regards,
Alexander.
