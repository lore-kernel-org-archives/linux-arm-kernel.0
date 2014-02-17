From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Feb 2014 11:08:07 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <CANqRtoRgMaAzzvD9OK+=_J2Or5HZHzg4RUb899-bXjM7LKHSyw@mail.gmail.com>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
 <20140217091900.GD2633@katana>
 <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
 <20140217093126.GE2633@katana>
 <CANqRtoRgMaAzzvD9OK+=_J2Or5HZHzg4RUb899-bXjM7LKHSyw@mail.gmail.com>
Message-ID: <20140217100807.GA4424@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> It won't break because anyone who modifies r8a7790 support need to
> make it specific to that SoC to not pull in r8a7791 into some
> assumption.

Geert's assumption was that exactly this can be forgotten. While this is
true, my point was that this is a bug. And as it turned out, neither
this or that solution helps the case :) It needs to be fixed or done
properly right from the beginning.

> realize that there is no shortcut for adding the compatible string to
> the driver. It has to be done sooner or later anyway.

OK, can be seen this way. As said before, I'll resend.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/da3468bd/attachment.sig>
