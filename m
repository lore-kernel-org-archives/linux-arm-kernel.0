From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 6 May 2016 10:05:06 -0300
Subject: [PATCH v3 1/3] leds: triggers: Allow to switch the trigger to
 "panic" on a kernel panic
In-Reply-To: <572C5DEE.3070307@samsung.com>
References: <1461881020-13964-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1461881020-13964-2-git-send-email-ezequiel@vanguardiasur.com.ar>
 <57230B26.9010300@samsung.com> <572C5DEE.3070307@samsung.com>
Message-ID: <CAAEAJfD_U1Z=wXQbK+DNdhZj5KEDkd3sK8mbBLNOvtKbZd1zYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 May 2016 at 06:03, Jacek Anaszewski <j.anaszewski@samsung.com> wrote:
> On 04/29/2016 09:20 AM, Jacek Anaszewski wrote:
>>
>> Hi Ezequiel,
>>
>> Thanks for the update. It's indeed reasonable to have all the
>> switching infrastructure in ledtrig-panic.c.
>>
>> I've noticed two minor issues below.
>
>
> Since the merge window is imminent, I've addressed those issues by
> myself and applied the patch set to the for-next branch
> of linux-leds.git.
>

Thanks a lot for taking care of this, Jacek!
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
