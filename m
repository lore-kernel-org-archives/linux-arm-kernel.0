From: alexey.zaytsev@gmail.com (Alexey Zaytsev)
Date: Mon, 21 May 2012 23:19:13 +0300
Subject: A good sub-architecture to base new ports on?
In-Reply-To: <201205181331.07566.arnd@arndb.de>
References: <CAB9v_DFdTkAFQWFthLncx5frJX0jed11CUoKXJDT-ac6j3hWOQ@mail.gmail.com>
 <CAB9v_DE-FRdyutcZL7EMpTv-9rXqoi+V15T_WyeP9CggrcMZdQ@mail.gmail.com>
 <4FB5343D.5090509@yahoo.es> <201205181331.07566.arnd@arndb.de>
Message-ID: <CAB9v_DGyOzK5JH56XnuW39icCSujrVfoySwD4-0sixVRaSsEDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 4:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 May 2012, Jorge Amor?s Argos wrote:
>> Hi Alexey and co,
>>
>> I up-ported Solos open code to Openwrt with Linux 2.6.30. I think the
>> only missing module was ADSL.

That's really nice. Did you get the wi-fi module working as well?

>
> Ah, very good!

I've got it working for 2.6.31, but that needs a lot of cleanup.

>
>> Anyway, compiling was successful but I can't tell if it was functional.
>>
>> Mainly 2 big issues:
>>
>> ? * No knowledge how to build the image (I wanted to have a self-lzma
>> ? ? image in order to save room)
>
> LZMA support was added to arm linux in 2.6.35, and XZ support some time
> after that.
>
>> ? * My Solos based router, Xavi 7968, is a bitchy one. I found no way to
>> ? ? easily upload firmware into flash. It took me hours to make 1 trial.
>>
>>
>> I'll be glad to share the code with whoever need it and maybe we can
>> take those old routers back to a better world.
>
> I think that would be helpful.

Yeah. I'll put my work somewhere publicly as well soon.
