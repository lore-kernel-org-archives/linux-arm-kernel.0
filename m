From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 6 May 2011 01:01:48 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTi=epFN2EZBj9n8pac6h7F4RWmyk+Q@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<BANLkTi=epFN2EZBj9n8pac6h7F4RWmyk+Q@mail.gmail.com>
Message-ID: <BANLkTi=fmTBs=kOwRQWROHWzAG7h_0T80w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 6 maja 2011 00:59 u?ytkownik Julian Calaby
<julian.calaby@gmail.com> napisa?:
> Rafa?,
>
> A minor nit:
>
> On Fri, May 6, 2011 at 07:59, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> diff --git a/Documentation/ABI/testing/sysfs-bus-bcma b/Documentation/ABI/testing/sysfs-bus-bcma
>> new file mode 100644
>> index 0000000..ad3cd69
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-bcma
>> @@ -0,0 +1,31 @@
>> +What: ? ? ? ? ?/sys/bus/bcma/devices/.../class
>> +Date: ? ? ? ? ?May 2011
>> +KernelVersion: 2.6.40
>> +Contact: ? ? ? Rafa? Mi?ecki <zajec5@gmail.com>
>> +Description:
>> + ? ? ? ? ? ? ? Each AXI core is identified by few fields, including class it
>> + ? ? ? ? ? ? ? belongs to. See include/linux/bcma/bcma.h for possible values.
>
> Should this not read BCMA or something similar, not AXI?
>
> Ditto for the rest of the changes to this file.

Ups, I left old name in this single place. Thx.

-- 
Rafa?
