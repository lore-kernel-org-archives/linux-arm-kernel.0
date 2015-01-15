From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 09:25:09 +0100
Subject: [PATCH v2 1/5] rtc: armada38x: Add the device tree binding
 documentation
In-Reply-To: <20150115092417.1db53b82@free-electrons.com>
References: <1421257155-3379-1-git-send-email-gregory.clement@free-electrons.com>	<1421257155-3379-2-git-send-email-gregory.clement@free-electrons.com>	<20150114202252.457d328e@free-electrons.com>	<54B7712F.2090509@free-electrons.com>
 <20150115092417.1db53b82@free-electrons.com>
Message-ID: <54B77965.4040201@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 15/01/2015 09:24, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 15 Jan 2015 08:50:07 +0100, Gregory CLEMENT wrote:
> 
>>> Any reason to use <0x184A0 0xC> instead of <0x184A8 0x4> ? According to
>>> the datasheet, there is only this 184A8 register for RTC stuff.
>>
>> Yes but according to the code I saw there were other registers related to the RTC
>> from 0x184A0. Even if we don't use them now I prefer having an accurate mapping from
>> the beginning for avoiding using negative offset as we needed to do in the past.
> 
> So I presume you mean that there are undocumented registers, since I
> didn't see them in the datasheet. Is this correct?

Yes indeed there are not documented in the current version of our datasheet.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
