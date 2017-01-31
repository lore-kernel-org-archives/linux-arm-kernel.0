From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 31 Jan 2017 09:41:32 +0000
Subject: [PULL v2] ARM: DTS: Fix broken GICv2 register maps
In-Reply-To: <20170131050648.GB16560@localhost> (Olof Johansson's message of
 "Mon, 30 Jan 2017 21:06:48 -0800")
References: <1485766389-30811-1-git-send-email-marc.zyngier@arm.com>
 <20170131050648.GB16560@localhost>
Message-ID: <86zii77eib.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31 2017 at 05:06:48 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi Marc, 
>
> On Mon, Jan 30, 2017 at 08:53:09AM +0000, Marc Zyngier wrote:
>> ARM-soc folks,
>> 
>> Please find below the pull request for a DT fix affecting a large
>> number of 32bit platforms, which has been acked by a number of
>> platform maintainers.
>> 
>> * From v1: Dropped the controvertial cortex-a15-gic->arm,gic-400
>>   change in the example, at Rob's request.
>> 
>> The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:
>> 
>>   Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)
>
> Any reason you had to base this on -rc4? We usually stick to an older
> -rc for all our branches, this cycle it's -rc3.

Ah, damn... No reason, just what I had at hand at the time this was put
together.

> Care to respin? Or I can just pick over the patches, as long as you
> don't need them as a stable base somewhere else.

If that works for you, please cherry pick the patches. I don't need them
to be based on anything in particular.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
