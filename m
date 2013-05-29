From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 29 May 2013 15:27:31 +0200
Subject: [PATCH 3/3] ARM PJ4B: Add support for errata 4611
In-Reply-To: <4523769.Zp7B72tmfz@wuerfel>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <20130529112207.GG13095@mudshark.cambridge.arm.com>
 <51A5FB26.4090000@free-electrons.com> <4523769.Zp7B72tmfz@wuerfel>
Message-ID: <51A60243.3000800@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 03:11 PM, Arnd Bergmann wrote:
> On Wednesday 29 May 2013 14:57:10 Gregory CLEMENT wrote:
>>
>> For the first point, unfortunately it is not possible as they are
>> errata for different CPUs. If finally the 2 last patches won't be
>> merged in 3.10, then I will add a new patch before them, to introduce
>> the PJ4B-MP which is the CPU used by the Armada XP whereas the
>> Armada 370 uses the PJ4B.
>>
>> For the second point and the other CPU specific questions you raised
>> in the other emails, I am waiting for answer from Marvell engineers.
> 
> I've been confused by the various CPU types before. If you have
> any information that's not yet in the excellent
> Documentation/arm/Marvell/README file that Thomas added, could you
> put it in there?
> 
> In particular, I'd like to understand what variants of PJ4 there
> are, and maybe you can list their cpuid part numbers.

OK I will see what kind of information I can gather and which ones I can
add to the Documentation/arm/Marvell/README file.

My current understanding is that there are at least 3 kind of CPU:
PJ4, PJ4B and PJ4B-MP and all of them belongs to the Sheeva family.

> 
> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
