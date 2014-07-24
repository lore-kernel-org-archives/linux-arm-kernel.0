From: schwab@suse.de (Andreas Schwab)
Date: Thu, 24 Jul 2014 15:40:04 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <CAKv+Gu_9HRwAxkJjT3KRvDbupp0yzstyq1dXsXkTu9M6swdCKQ@mail.gmail.com>
 (Ard Biesheuvel's message of "Thu, 24 Jul 2014 15:29:57 +0200")
References: <mvmvbri4k06.fsf@hawking.suse.de>
 <CAKv+Gu-NAVjMR-Jkw=W-8f7M5FSsQOSdzYN6A0kHDd1m0WA8EA@mail.gmail.com>
 <mvmr4264i1p.fsf@hawking.suse.de>
 <CAKv+Gu8SbM_Z=ymBFb2D4EWJeo-6dWuKqE2YNOkqJTKLDEJcYA@mail.gmail.com>
 <mvm4my7j5xh.fsf@hawking.suse.de>
 <CAKv+Gu-6rUxUnF+dRuroDJqy2K2B5F0r7_bm0X-vyiuQ-83W5w@mail.gmail.com>
 <CAKv+Gu96k7GOVR85EXtro3Lt0jjiJqxyvT9cwJZ1qc6uzq97bw@mail.gmail.com>
 <mvmvbqmj3b2.fsf@hawking.suse.de>
 <CAKv+Gu_9HRwAxkJjT3KRvDbupp0yzstyq1dXsXkTu9M6swdCKQ@mail.gmail.com>
Message-ID: <mvmr41aj2ob.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

> On 24 July 2014 15:26, Andreas Schwab <schwab@suse.de> wrote:
>> You are not using CONFIG_MODVERSIONS.
>>
>
> I am

No, you aren't, since you say that your .cmd contains a command to
create aes-glue-ce.o, which with CONFIG_MODVERSIONS it doesn't.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
