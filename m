From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Apr 2017 14:34:03 +0200
Subject: [PATCH] pinctrl: at91-pio4: handle suspend to ram
In-Reply-To: <20170407104846.5ghrcqc2ws4dkqxt@piout.net>
References: <20170406133623.19160-1-alexandre.belloni@free-electrons.com>
 <CACRpkdYFPhewV4NLNxxVkXCwuyoo3rgeLt0auErS47R=055FHQ@mail.gmail.com>
 <20170407104846.5ghrcqc2ws4dkqxt@piout.net>
Message-ID: <CACRpkdZ=7e71XR++RWY8j5Lqb_UF6oMZzibCRo=76b8YPvcPiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 12:48 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 07/04/2017 at 12:16:22 +0200, Linus Walleij wrote:
>> On Thu, Apr 6, 2017 at 3:36 PM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>>
>> > When suspending to RAM, the power to the core is cut and the register
>> > values are lost. Save and restore more registers than just IMR.
>> >
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
>> Should this be tagged for stable?
>>
>
> No because that particular suspend to ram mode is not yet implemented
> upstream.
>
>> Waiting for input from the AT91 maintainers here.
>>
>
> Well, I've been an AT91 maintainer for 2 years now and I have done all
> the AT91 pull requests since 3.16. I hope this qualifies me here.

So much for trying to keep MAINTAINERS in my head :(

I wish there was gmail integration so I could annotate people
with roles...

Patch applied.

Yours,
Linus Walleij
