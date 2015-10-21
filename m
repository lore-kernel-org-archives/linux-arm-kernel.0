From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:23:03 +0100
Subject: [PATCH 14/19] ARM: dts: shmobile/r8a7xxx: replace gpio-key, wakeup
 with wakeup-source property
In-Reply-To: <CAMuHMdXpY7gSOPAGxh9Z_LurpL392y7Vx0pBe-FqfauXjVnMFQ@mail.gmail.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-15-git-send-email-sudeep.holla@arm.com>
 <CAMuHMdXpY7gSOPAGxh9Z_LurpL392y7Vx0pBe-FqfauXjVnMFQ@mail.gmail.com>
Message-ID: <56276787.6090900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 11:18, Geert Uytterhoeven wrote:
> On Wed, Oct 21, 2015 at 12:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
>> check for/support the legacy "gpio-key,wakeup" boolean property to
>> enable gpio buttons as wakeup source, "wakeup-source" is the new
>> standard binding.
>>
>> This patch replaces the legacy "gpio-key,wakeup" with the unified
>> "wakeup-source" property in order to avoid any futher copy-paste
>> duplication.
>
> Thanks!
>
> I made the same changes to my local tree a few weeks ago, but never found
> time to send them out...
>

Ah OK, even I had these changes for long. I waited until I fixed all the
binding documents(which was boring ;))

>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: linux-sh at vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks

-- 
Regards,
Sudeep
