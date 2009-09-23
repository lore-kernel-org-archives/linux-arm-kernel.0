From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 24 Sep 2009 08:57:24 +1200
Subject: [PATCH] ep93xx/micro9: Update platform code and maintainer
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42430@mi8nycmail19.Mi8.com>
References: <75467E8A2C28434DA9302761D4D2B6FDB02DC9@coexs.contec-int.at>
	<4ABA87EB.5040804@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42430@mi8nycmail19.Mi8.com>
Message-ID: <4ABA8BB4.6050707@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Wednesday, September 23, 2009 1:41 PM, Ryan Mallon wrote:
>> Hubert Feurstein wrote:
>>> ARM: Update Contec Micro9 maintainer and add entry in MAINTAINERS
>>>      Update Contec Micro9 platform code and add Micro9-Slim support
>>>
>>> Signed-off-by: Hubert Feurstein <hubert.feurstein@contec.at>
>>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>> Cc: Manfred Gruber <m.gruber@tirol.com>
>>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> Could we separate this out into two patches, one which updates the
>> MAINTAINERS file, and the maintainer in the comments, and one which
>> makes code changes. The two aren't really related.
> 
> Ryan,
> 
> I normally would agree but the change to micro9.c is pretty large.
> There could be some patch reject issues depending on the order the
> patches are picked up and applied.

They could be posted as a series of 2 so that they are applied in the
correct order. It shouldn't be a big issue.

> How about just a split into a MAINTAINERS file patch and a code patch?

That would be better than a single patch.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan at bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934
