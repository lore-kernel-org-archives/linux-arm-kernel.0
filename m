From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 21 Aug 2013 16:19:35 -0700
Subject: [PATCH 0/3] ARM: vexpress_defconfig: Allow to boot using a
 regular filesystem on SD card
In-Reply-To: <CACRpkdbruw8J26cva-kgXXZuMM-8z9BFpuaY=_QJqCzYYdVaqw@mail.gmail.com>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
 <1377075956.3591.23.camel@linaro1.home>
 <1377082313.10707.11.camel@hornet>
 <CACRpkdbruw8J26cva-kgXXZuMM-8z9BFpuaY=_QJqCzYYdVaqw@mail.gmail.com>
Message-ID: <CAMJs5B9-u2ciE6B98rGXyO2fZKUtTn1AhDtYk5nMwu0DR_5P=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2013 15:57, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 21, 2013 at 12:51 PM, Pawel Moll <pawel.moll@arm.com> wrote:
>
>> This gets down to the question do we actually want the
>> vexpress_defconfig at all?
>
> I added it because people were complaining that I was not
> testing code against Vexpress and there was no way to
> conveniently do that without a defconfig.
>
> It is also used in Rothwells kisskb:
> http://kisskb.ellerman.id.au/kisskb/branch/9/
>
And it's mentioned in a wide variety of guides concerning building
QEMU/KVM guest images - I think it would be premature to remove it.

-Christoffer
