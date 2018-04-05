From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 22:42:06 +0200
Subject: [PATCH v1 2/2] arm: npcm: Enable L2 Cache in NPCM7xx
In-Reply-To: <CAP6Zq1j9i0Zdt3wPCGLLnPZJPGf8BaG9Nh1pLAsnwczqWHtthQ@mail.gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
 <1521155412-29229-3-git-send-email-tmaimon77@gmail.com>
 <CAFd5g44NOFRmQbDJfRLw_SwsHwVB-hxsUYMYSmkqeyRKmXqSqQ@mail.gmail.com>
 <CAP6Zq1jvCvM+uG8kU_JAYzm9e3BG28AS80ANmn_0a0HmiVBm3A@mail.gmail.com>
 <CAK8P3a3HBkqgas-QkAr_J767ffBMXJTJeqqVY9fFxw2Yexi27g@mail.gmail.com>
 <CAP6Zq1j9i0Zdt3wPCGLLnPZJPGf8BaG9Nh1pLAsnwczqWHtthQ@mail.gmail.com>
Message-ID: <CAK8P3a1zvjc8EyXX+c4r++pVHrVQ84CSUrnMA=+9kf7FZojiGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 6:56 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> On 5 April 2018 at 15:54, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Mar 16, 2018 at 10:51 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> It seems that I have to add l2c_aux_val, l2c_aux_mask parameters to the
> DT_MACHINE_START
> to enable the L2 Cache.
>>
>>
>> The last email in that thread mentions
>> L310_AUX_CTRL_CACHE_REPLACE_RR, is that required after all?
>
>
> No it is not require this is why I added:
> .l2c_aux_val    = 0x0,
> .l2c_aux_mask   = ~0x0,
>
> Can I resend it on Sunday?

Yes, please resend it as soon as you have the time to improve the changelog,
no need to wait if you can do it right away. We can always merge bugfixes,
but doing it earlier rather than later is better.

      Arnd
