From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 23 Sep 2009 16:49:02 -0400
Subject: [PATCH] ep93xx/micro9: Update platform code and maintainer
In-Reply-To: <4ABA87EB.5040804@bluewatersys.com>
References: <75467E8A2C28434DA9302761D4D2B6FDB02DC9@coexs.contec-int.at>
	<4ABA87EB.5040804@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42430@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 23, 2009 1:41 PM, Ryan Mallon wrote:
> Hubert Feurstein wrote:
>> ARM: Update Contec Micro9 maintainer and add entry in MAINTAINERS
>>      Update Contec Micro9 platform code and add Micro9-Slim support
>> 
>> Signed-off-by: Hubert Feurstein <hubert.feurstein@contec.at>
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Manfred Gruber <m.gruber@tirol.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>
> Could we separate this out into two patches, one which updates the
> MAINTAINERS file, and the maintainer in the comments, and one which
> makes code changes. The two aren't really related.

Ryan,

I normally would agree but the change to micro9.c is pretty large.
There could be some patch reject issues depending on the order the
patches are picked up and applied.

How about just a split into a MAINTAINERS file patch and a code patch?

Regards,
Hartley
