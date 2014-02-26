From: dirk.behme@gmail.com (Dirk Behme)
Date: Wed, 26 Feb 2014 18:13:15 +0100
Subject: [PATCH v2] arm: fix memset-related crashes caused by recent GCC
 (4.7.2) optimizations
In-Reply-To: <CAGVrzcaAGqWG4-fiVc+YiPms5aqSkoXBMmK4rR=wr9XQJ083jw@mail.gmail.com>
References: <1360587435-28386-1-git-send-email-ivan.djelic@parrot.com>
 <513795C5.4050608@gmail.com> <20130307151755.GB4977@n2100.arm.linux.org.uk>
 <513CBD83.7040909@ahsoftware.de>
 <20130310172854.GH4977@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1303110910540.28820@syhkavp.arg>
 <513EFE1F.5060807@ahsoftware.de>
 <CAGVrzcaAGqWG4-fiVc+YiPms5aqSkoXBMmK4rR=wr9XQJ083jw@mail.gmail.com>
Message-ID: <530E20AB.80301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.02.2014 01:43, schrieb Florian Fainelli:
> 2013-03-12 3:06 GMT-07:00 Alexander Holler <holler@ahsoftware.de>:
>>
>> Tested-by: Alexander Holler
>>
>> It works since 2 days on my busy 24/7 armv5-thingy without me having seen an
>> error. A quick test on an armv7-system hasn't revealed any problems too.
>
> This is an old thread, but 3.8.13 is still affected, not quite sure if
> there will be a 3.8.14 release, but if there is, we should
> definitively get:
>
> ARM: 7668/1: fix memset-related crashes caused by recent GCC (4.7.2)
> optimizations
> ARM: 7670/1: fix the memset fix
>
> included in 3.8.14.

Ubuntu is continuing support for some kernels with -stable patches:

https://lwn.net/Articles/550581/

http://kernel.ubuntu.com/git?p=ubuntu/linux.git

Having a short check in v3.8.13.18, this patch is not included there, 
yet. Maybe you want to ask them if they want to include it.

Best regards

Dirk
