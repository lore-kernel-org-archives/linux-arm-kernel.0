From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Apr 2012 09:39:30 -0700
Subject: [CPUFREQ] Fix exposure of ARM_EXYNOS4210_CPUFREQ
In-Reply-To: <20120404150353.GB24211@n2100.arm.linux.org.uk>
References: <20120213094940.GA15338@n2100.arm.linux.org.uk>
 <4F3CF3DA.7000806@samsung.com>
 <20120216160250.GP13673@n2100.arm.linux.org.uk>
 <00aa01ccf084$93c98a70$bb5c9f50$%kim@samsung.com>
 <20120327074931.GK5611@n2100.arm.linux.org.uk> <4F73B3E1.4080807@samsung.com>
 <20120404145204.GA24211@n2100.arm.linux.org.uk>
 <20120404145917.GB1929@redhat.com>
 <20120404150353.GB24211@n2100.arm.linux.org.uk>
Message-ID: <4F7C7942.2000006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/12 08:03, Russell King - ARM Linux wrote:
> On Wed, Apr 04, 2012 at 10:59:17AM -0400, 'Dave Jones' wrote:
>> On Wed, Apr 04, 2012 at 03:52:04PM +0100, Russell King - ARM Linux wrote:
>>   >  On Wed, Mar 28, 2012 at 05:59:13PM -0700, Kukjin Kim wrote:
>>   >  >  Russell King wrote:
>>   >  >>  As predicted, this is breaking other ARM platforms.  Please fix this
>>   >  >>  yourself before your crappy code gets pushed into mainline.  Thanks.
>>   >  >>
>>   >  >  I fixed it.
>>   >
>>   >  When will we see patches or the fix in mainline?
>>
>> Just send it to Linus directly.
>
> 'it'... well, that implies that someone already has a patch.  I've asked
> Kukjin to fix the problem which he introduced because exynos is getting
> rather complicated, and he'll know what the dependencies should be.  So
> far I've yet to see any kind of patch fixing this stuff.
>
Well, I already submitted its fix and it was including your e-mail. See 
below.

http://www.spinics.net/lists/cpufreq/msg03080.html

> Meanwhile I'm seeing failing randconfig builds for non-exynos ARM for
> about a week due to the lack of dependencies.
>

Yeah, the failure from cpufreq exynos4x12 and exynos5250 has been 
introduced from last merge window and you know exynos4210 has been fixed 
by your patch last time.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
