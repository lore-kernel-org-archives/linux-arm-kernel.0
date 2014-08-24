From: daniel@zonque.org (Daniel Mack)
Date: Sun, 24 Aug 2014 13:13:48 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <87d2bq43pc.fsf@free.fr>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>	<CAN1soZwDDwiLuVkT7kRJX-wy-UmyDj-2yiReGrpBrTOJkKpuSA@mail.gmail.com>	<87ha1342ei.fsf@free.fr>
 <1465795.XsPpj3dZHX@wuerfel> <87d2bq43pc.fsf@free.fr>
Message-ID: <53F9C8EC.8080301@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2014 11:49 AM, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

>> For the specific case of PXA, I wonder if we should update the
>> maintainer entry. As far as I can tell, Eric and Russell are no
>> longer actively involved in the maintenance of PXA, and Haojian
>> is doing only the bare minimum and is kept busy by other platforms
>> these days (mach-hisi, mach-mmp). Should we perhaps add you and/or
>> Daniel and remove some of the others if they are no longer as
>> actively working on PXA?
> 
> Sure, I'll send a patch to add myself to the MAINTAINERS of pxa. Would be great
> if Daniel stepped in too, as my pxa3xx knowledge is poor.

Sure, why not. However, I only have one platform to test PXA3xx stuff
on, and that's a custom-made one that is not very versatile. Hence, I
always thought that a maintainer who's employed by the chip vendor is a
very good thing to have, because I'd imagined the vendor usually has
access to a wider range of different hardware.

Also, I'm no longer actively working with this platform for my day job,
so my efforts will be limited to my spare time. But after all, PXA has
been quite calm over the years now. The only bigger topics that will
consume some time in the future seem to be DT and DMA.

> As to removing Russell and Eric, we should get their opinion, it's as they want,
> I can send it in the maintainers patch if they agree.

Yes, I'd definitely like to hear their opinion, too.


Daniel
