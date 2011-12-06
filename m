From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Dec 2011 17:14:23 +0800
Subject: Error of 'handle_local_timer' missing in plat-mxc/gic.c when
 building 'mx5-merge' branch
In-Reply-To: <CAMPhdO-KyXDw-aR0NGSyQ_rzp5bpAjc=s-EttWz9qS+kK2s1Rw@mail.gmail.com>
References: <CAMPhdO8ArDykEgXn6rdttPF3d6c_MUB4Bukh85VMNCYwg9Ezjw@mail.gmail.com>
 <CAAQ0ZWSZJthOvw0EY3Of-Sn=n85H5VJSaFEZjgqGeUduKkLeZw@mail.gmail.com>
 <CAMPhdO-KyXDw-aR0NGSyQ_rzp5bpAjc=s-EttWz9qS+kK2s1Rw@mail.gmail.com>
Message-ID: <CAAQ0ZWTYcZe5SWCCpBNXp8xHuji-61BSywgYq0+KGohnipLFzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2011 17:11, Eric Miao <eric.miao@linaro.org> wrote:
> On Tue, Dec 6, 2011 at 5:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On 6 December 2011 16:40, Eric Miao <eric.miao@linaro.org> wrote:
>>> Hi Sascha,
>>>
>>> Just FYI,
>>>
>>> ?CC ? ? ?arch/arm/plat-mxc/gic.o
>>> /home/ycmiao/linux-2.6/arch/arm/plat-mxc/gic.c: In function 'gic_handle_irq':
>>> /home/ycmiao/linux-2.6/arch/arm/plat-mxc/gic.c:44:4: error: implicit
>>> declaration of function 'handle_local_timer'
>>> make[2]: *** [arch/arm/plat-mxc/gic.o] Error 1
>>> make[1]: *** [arch/arm/plat-mxc] Error 2
>>> make: *** [sub-make] Error 2
>>>
>>> Do we have a fix somewhere already?
>>>
>> This should be fixed by Marc's series below, which has hit the mainline.
>>
>
> Awesome. I'll do a quick merge and test if that's working.
>
> Marc,
>
> What's the status of the branch?
>
Sorry, I was mistaken here.  Please ignore it, and let me find the
correct patch.

-- 
Regards,
Shawn
