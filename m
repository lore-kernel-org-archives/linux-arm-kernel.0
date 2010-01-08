From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 8 Jan 2010 08:29:38 +0000
Subject: Please pull bjdooks' for-linus/samsung
In-Reply-To: <4B46E3C3.2080303@gmail.com>
References: <E1NT4JR-0006WN-6J@trinity.fluff.org> <4B46E3C3.2080303@gmail.com>
Message-ID: <20100108082938.GD1224@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 09:50:27AM +0200, Paulius Zaleckas wrote:
> On 01/08/2010 04:10 AM, Ben Dooks wrote:
>> The following changes since commit c5974b835a909ff15c3b7e6cf6789b5eb919f419:
>>    Linus Torvalds (1):
>>          Merge branch 'limits_cleanup' of git://decibel.fi.muni.cz/~xslaby/linux
>>
>> are available in the git repository at:
>>
>>    git://git.fluff.org/bjdooks/linux.git for-linus/samsung
>>
>> Ben Dooks (1):
>>        ARM: S3C64XX: Fix possible clock look in EPLL and MPLL clock chains
>
> Spelling look/lock

should have been loop.

turns out that in certain situations the clock can become parented to
itself, thus causing bad-things(tm) to happen.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
