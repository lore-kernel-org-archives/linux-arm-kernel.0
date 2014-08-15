From: zonque@gmail.com (Daniel Mack)
Date: Fri, 15 Aug 2014 10:41:29 +0200
Subject: [PATCH 1/2] ARM: pxa: ssp: provide platform_device_id for PXA3xx
In-Reply-To: <CAN1soZyj+ddcuP60F5kB2pwUYGYG7bF6mFckoak97xr6n7wCYg@mail.gmail.com>
References: <1407959959-4977-1-git-send-email-zonque@gmail.com>	<CAN1soZz0Fo_PNvc1dK7d9ZU49Pi0FortL4k1dwAjHEDZNcf_zg@mail.gmail.com>	<53EC74B4.1050007@gmail.com>
 <CAN1soZyj+ddcuP60F5kB2pwUYGYG7bF6mFckoak97xr6n7wCYg@mail.gmail.com>
Message-ID: <53EDC7B9.9060000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2014 10:33 AM, Haojian Zhuang wrote:
> On Thu, Aug 14, 2014 at 4:35 PM, Daniel Mack <zonque@gmail.com> wrote:

>> That's a regression caused by 972a55b62 ("ASoC: fix pxa-ssp compiling
>> issue under mach-mmp"), btw, that added the PXA3xx_SSP enum value but
>> forgot to make sure it is actually used.
>>
>> Hence, this commit could even get a stable tag for 3.5+.
>>
>>
> Yes, you're right. We should append this string.

The stable@ tag you mean? Well, OTOH, it went unnoticed since 3.5, so we
can as well just apply it for 3.17 :)


Thanks,
Daniel
