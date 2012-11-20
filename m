From: narkewoody@gmail.com (Woody Wu)
Date: Tue, 20 Nov 2012 08:23:04 +0000 (UTC)
Subject: s3c2410 (Linux 2.6.36) Incorrect DRAM size
References: <slrnkactau.29u.narkewoody@zuhnb712.local.com>
 <CA+E=qVe3=cCLuELB7tuHp2Qis6_2EL_Q_XgC+aUk4398HysPSQ@mail.gmail.com>
Message-ID: <slrnkamfdo.9pu.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-16, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 8:19 PM, Woody Wu <narkewoody@gmail.com> wrote:
>> Hi,
>>
>> I just buit a 2.6.36 and boot it from a s3c2410 board.  At the very
>> beginning of consol log, the kernel reports the DRAM size if 16M.
>> (Memory: 16M = 16M total).  But the board actually has 64M ram in two
>> bands (each is 32M).
>>
>> Did someone know the cause and have a hint or solution? And, does anyone
>> knows that the DRAM size is auto-detected by kernel or hard configured
>> in some .h?
>
> Bootloader passes ATAGs with memory location and size, so something's
> wrong with your bootloader.
>

Thanks. I also noticed this might be the cause, I am not trying to
printk some log info in the parse_tags() procedure.  If I have some
finding, I will let you know.

-- 
woody
I can't go back to yesterday - because I was a different person then.
