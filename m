From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 May 2015 14:45:46 +0200
Subject: [PATCH] ARM: dts: kirkwood: add "nor-jedec" flash compatible
 binding
In-Reply-To: <CACna6rzSPzdCYLPBGYNZB4QKoU_kgPan7aS9p0KWwj0e78JcKg@mail.gmail.com>
References: <1431066079-19725-1-git-send-email-zajec5@gmail.com>	<5550AA08.5060001@free-electrons.com>
 <CACna6rzSPzdCYLPBGYNZB4QKoU_kgPan7aS9p0KWwj0e78JcKg@mail.gmail.com>
Message-ID: <5555EA7A.6090809@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafa?,

On 12/05/2015 07:07, Rafa? Mi?ecki wrote:
> On 11 May 2015 at 15:09, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> On 08/05/2015 08:21, Rafa? Mi?ecki wrote:
>>> Starting with commits
>>> 8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
>>> 1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
>>> we have "nor-jedec" binding indicating support for JEDEC identification.
>>
>> I have the same question that for mvebu: did you actually check that all
>> the NOR flash referenced in the dts supports the JEDEC identification?
> 
> Yes, I checked *all* of them.
> 
> 
>> Then again, if it id the case I will add it in mvebu/dt soon, unless Andrew,
>> Jason or any other developer who has submitted the dts is aware of a restriction
>> about applying it.
> 
> Please wait to see if the binding will be changed or not (tegre patch
> thread discussion).
> 
OK I won't take them, and I am waiting for a v2.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
