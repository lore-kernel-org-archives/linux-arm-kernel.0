From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 10 Apr 2013 13:26:12 +0200
Subject: [PATCH] ARM: hw_breakpoint: Do not use __cpuinitdata for
 dbg_cpu_pm_nb
In-Reply-To: <20130410111148.GA26992@mudshark.cambridge.arm.com>
References: <1365588278-5185-1-git-send-email-hechtb+renesas@gmail.com>
 <20130410111148.GA26992@mudshark.cambridge.arm.com>
Message-ID: <CABYn4szw=kE_DD1eNZ-CsM__o_cJUA5+F4M8T5-Uyf_nw+bfGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/10 Will Deacon <will.deacon@arm.com>:
> On Wed, Apr 10, 2013 at 11:04:38AM +0100, Bastian Hecht wrote:
>> We must not declare dbg_cpu_pm_nb as __cpuinitdata as we need it after
>> system initialization for Suspend and CPUIdle.
>>
>> This was done in commit 9a6eb310eaa5336b89a27a0bbb78da4bba35f6f1
>> ARM: hw_breakpoint: Debug powerdown support for self-hosted debug
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>
> Thanks Bastian, I'll take this into my tree.
>
> Will

Nice, thanks!
