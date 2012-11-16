From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 16 Nov 2012 10:17:42 +0100
Subject: [PATCH 0/2] clk: ux500: Make mtu driver use apb_pclock
In-Reply-To: <20121115185435.7155.53498@nucleus>
References: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
 <20121112183615.17970.20162@nucleus>
 <CACRpkdYmPvRLcEjSNwC51sZw+g3iH3a5r7+7USEWJONmR4q4JQ@mail.gmail.com>
 <201211151221.30217.arnd@arndb.de>
 <CACRpkdaFkS_8i=8FmVYujzm1cMe1+=SO6MJyUbFyFPX7xhz-YA@mail.gmail.com>
 <20121115185435.7155.53498@nucleus>
Message-ID: <CAPDyKFq__PsZCZKnt=E8pS6RhZkQQ51VOhFUP80KXQHDNA6O7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2012 19:54, Mike Turquette <mturquette@ti.com> wrote:
> Quoting Linus Walleij (2012-11-15 05:29:32)
>> On Thu, Nov 15, 2012 at 1:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> > If I understand the problem at hand correctly, the safe solution
>> > should be to base the ux500 clk changes on top of c3b9d1db23c4e,
>> > which is in the nomadik/plat-removal branch in arm-soc that got
>> > merged into next/multiplatform. I would prefer if you use that
>> > as a base instead of the larger next/multiplatform branch that
>> > also contains vt8500 and other changes.
>>
>> OK I'll take a stab at this and see if I can fix it...

Thanks Linus!

>>
>
> I've dropped both of these patches from clk-next.
>

Thanks Mike!

> Regards,
> Mike
>
>> Yours,
>> Linus Walleij


Kind regards
Ulf Hansson
