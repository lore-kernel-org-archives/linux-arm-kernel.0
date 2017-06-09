From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jun 2017 11:21:00 +0200
Subject: [PATCH] arm: boot/compressed: fix inappropriate Thumb2 mnemonic
 for __nop
In-Reply-To: <CAKv+Gu-SBpZ7VAvjWFpZYhVeUjU=KKBGgYbc983Ncc9ZzUjAHg@mail.gmail.com>
References: <20170608125847.2611-1-ard.biesheuvel@linaro.org>
 <20170608162939.GQ4902@n2100.armlinux.org.uk>
 <CAKv+Gu-SBpZ7VAvjWFpZYhVeUjU=KKBGgYbc983Ncc9ZzUjAHg@mail.gmail.com>
Message-ID: <CAK8P3a2X2iB-F+MbHoLrWKf5ErqxwxOWAaf-kamwnPs1kTLR7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 11:15 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 8 June 2017 at 16:29, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>> Gah, it's rather unfortunate that this has been discovered only a
>> few days after the other decompressor fix was merged and hit Linus'
>> tree...
>>
>
> I guess that is where Arnd found it, although he didn't specify. In
> any case, apologies for the breakage and thanks to Arnd for reporting
> it.

I found it in linux-next randconfig tests, but I had not updated my tree for
a few days before it, so it probably escaped my testing when it was in
linux-next and not yet in mainline.

      Arnd
