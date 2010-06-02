From: nobin.mathew@gmail.com (Nobin Mathew)
Date: Wed, 2 Jun 2010 21:38:52 +0530
Subject: make ARM=arm menuconfig problem in mainline
In-Reply-To: <20100602085748.6771e025.randy.dunlap@oracle.com>
References: <AANLkTikC61Y9g-WbqwgGDghDSy2XtgraFSRoZYkHRGTG@mail.gmail.com>
	<AANLkTilEYHVHJrj_KgF48OYCSEUcsKLi57Q_Y73d9va-@mail.gmail.com>
	<20100602085748.6771e025.randy.dunlap@oracle.com>
Message-ID: <AANLkTilpzeYVExQfLgpVmS3bPvb_h3kmWaatidekI-0r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry if attachments are not allowed, when I go to select ARM system
type(OMAP, Davinci etc), I am not seeing any entries there in the pop
up window. When I remove  bool "Samsung S3C2410, S3C2412, S3C2413,
S3C2416, S3C2440,
>> S3C2442, S3C2443, S3C2450"  it is working fine. I feel it is something to do with length of that string.

Thanks
Nobin

On Wed, Jun 2, 2010 at 9:27 PM, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Wed, 2 Jun 2010 20:04:28 +0530 Nobin Mathew wrote:
>
>> adding linux-arm-kernel at lists.infradead.org
>>
>> Hi,
>>
>> The following entry creates problem in ARM System type menu. I am
>> using a Fedora 12 system.
>
> What kind of problem does it create?
> It seems to work for me (on f11, not f12).
> Does it have something to do with F12 specifically?
>
>
>> Length of bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440,
>> S3C2442, S3C2443, S3C2450" is the problem. How can I fix it.
>
> Describe the problem, please.
>
>> config ARCH_S3C2410
>> ? ? ? ?bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440,
>> S3C2442, S3C2443, S3C2450"
>> ? ? ? ?select GENERIC_GPIO
>> ? ? ? ?select ARCH_HAS_CPUFREQ
>> ? ? ? ?select HAVE_CLK
>> ? ? ? ?select ARCH_USES_GETTIMEOFFSET
>> ? ? ? ?help
>> ? ? ? ? ?Samsung S3C2410X CPU based systems, such as the Simtec Electronics
>> ? ? ? ? ?BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
>> ? ? ? ? ?the Samsung SMDK2410 development board (and derivatives).
>>
>> ? ? ? ? ?Note, the S3C2416 and the S3C2450 are so close that they even share
>> ? ? ? ? ?the same SoC ID code. This means that there is no seperate machine
>> ? ? ? ? ?directory (no arch/arm/mach-s3c2450) as the S3C2416 was first.
>
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Screenshot.jpg
Type: image/jpeg
Size: 107216 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100602/d459a275/attachment-0001.jpg>
