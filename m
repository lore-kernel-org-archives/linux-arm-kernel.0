From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 20 May 2014 15:01:45 +0200
Subject: [GIT PULL] Renesas SoC Clock Cleanups for v3.1
In-Reply-To: <20140520053839.GM18956@quad.lixom.net>
References: <cover.1399967755.git.horms+renesas@verge.net.au>
 <20140520053839.GM18956@quad.lixom.net>
Message-ID: <537B5239.8090005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2014 07:38 AM, Olof Johansson wrote:
> On Tue, May 13, 2014 at 05:03:41PM +0900, Simon Horman wrote:
>> Hi Olof, Hi Kevin, Hi Arnd,
>>
>> Please consider these Renesas SoC Clock Cleanups for v3.16.
>>
>> This pull request is based a merge of the following to provide dependencies
>> and avoid conflicts.
>>
>> * Renesas ARM Based SoC Board Updates for v3.16,
>>    tagged as renesas-boards-for-v3.16, which you have already pulled.
>>
>> * Renesas ARM Based SoC Clock Updates for v3.16,
>>    tagged as renesas-clock-for-v3.16, which you have already pulled.
>>
>> * The cmt-mtu2-tmu-cleanups-for-v3.16 branch of
>>    Daniel Lezcano's tree.
>>
>>    git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/cmt-mtu2-tmu-cleanups
>
> Daniel, I don't think we were part of a three-way handshake on this. Is
> this branch 100% guaranteed to be stable between now and when Linus will
> merge it, i.e. it will never be rebased? If so, we can pull in a copy
> of it. If not, well, that'll get difficult.

Hi Olof,

actually, it is a common branch between Simon and I.

The branch clockevents/cmt-mtu2-tmu-cleanups contains Laurent's changes 
which was pulled into Simon's branch as described above.

This branch has been merged into my clockevents/3.16 branch which will 
be pulled by Thomas into tip/timers/core.

Nobody else should pull from clockevents/cmt-mtu2-tmu-cleanups IIUC.

In any case, clockevents/cmt-mtu2-tmu-cleanups won't be changed until 
they are pulled.

It is the second time I use this procedure, I could have missed 
something but I believe I applied it carefully.

Let me know if you think something is wrong.

Cc'ed Thomas.

Thanks

   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
