From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Tue, 17 Nov 2015 11:43:27 +0100
Subject: [PATCH] [media] move media platform data to
 linux/platform_data/media
In-Reply-To: <7319142.Cp8MurgLWk@wuerfel>
References: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
 <7319142.Cp8MurgLWk@wuerfel>
Message-ID: <564B04CF.1090507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 17.11.2015 10:23, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 07:15:59 Mauro Carvalho Chehab wrote:
>> Now that media has its own subdirectory inside platform_data,
>> let's move the headers that are already there to such subdir.
>>
>>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Why does dma-imx.h also moved? It's the generic file, not a media specific.

BR, Anton
