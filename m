From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 19:11:14 +0900
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <20140217100807.GA4424@katana>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
 <20140217091900.GD2633@katana>
 <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
 <20140217093126.GE2633@katana>
 <CANqRtoRgMaAzzvD9OK+=_J2Or5HZHzg4RUb899-bXjM7LKHSyw@mail.gmail.com>
 <20140217100807.GA4424@katana>
Message-ID: <CANqRtoRumYg15MnZJyow67h=SGSt079GAuY+e5S9KwK-Z0wc9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 7:08 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> It won't break because anyone who modifies r8a7790 support need to
>> make it specific to that SoC to not pull in r8a7791 into some
>> assumption.
>
> Geert's assumption was that exactly this can be forgotten. While this is
> true, my point was that this is a bug. And as it turned out, neither
> this or that solution helps the case :) It needs to be fixed or done
> properly right from the beginning.
>
>> realize that there is no shortcut for adding the compatible string to
>> the driver. It has to be done sooner or later anyway.
>
> OK, can be seen this way. As said before, I'll resend.

Thanks! I'd be happy to discuss this more over a beverage in the not
so distant future! =)

/ magnus
