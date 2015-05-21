From: stefan@agner.ch (Stefan Agner)
Date: Thu, 21 May 2015 11:27:48 +0200
Subject: [PATCH defconfig] ARM: add =?UTF-8?Q?ARM=5FSINGLE=5FARMV=37M?=
 =?UTF-8?Q?=20in=20ARMv=37-M=20defconfigs?=
In-Reply-To: <20150521082604.GZ24769@pengutronix.de>
References: <1432161501-2323-1-git-send-email-stefan@agner.ch>
 <20150521082604.GZ24769@pengutronix.de>
Message-ID: <2ddf1a3a6386cf4bb692b7a202346910@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-21 10:26, Uwe Kleine-K?nig wrote:
> On Thu, May 21, 2015 at 12:38:21AM +0200, Stefan Agner wrote:
>> Select ARM_SINGLE_ARMV7M in defconfigs of the converted ARMv7-M
>> platforms.
> I assume this relates to your series that introduces this symbol. Should
> the defconfig update happen before? (Or what is the result if
> CONFIG_ARM_SINGLE_ARMV7M=y is missing in the defconfig while the symbol
> already exists?) Maybe this should be squashed into the commit in
> question?

The Kconfig system defaults to versatile then, it tried yesterday and I
think it and it compiled fine actually. However, it is of course not
what the user wants.

The defconfigs of the new machines are currently in arm-soc
next/defconfig. While testing, I just merged the defconfig branch into
the soc branch, but then splitted the patch in two independent patches.
Arnd, what do you think?

--
Stefan
