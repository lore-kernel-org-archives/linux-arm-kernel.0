From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 19 May 2014 23:41:04 +0100
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <4931877.zNfKfvcgox@wuerfel>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140516184205.GL27822@titan.lakedaemon.net>
 <1400278842.2647.62.camel@deadeye.wl.decadent.org.uk>
 <4931877.zNfKfvcgox@wuerfel>
Message-ID: <CAFEAcA-1d_47g3Z3R=CNyE8U5+huJ0yDvAMU+BRacajxE5qPXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2014 13:20, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 16 May 2014 23:20:42 Ben Hutchings wrote:
>> Versatile is one of ARM's own development boards, but more importantly
>> it's something QEMU can emulate.
>
> We should really have this in multiplatform soon, I think the last issue
> for versatile is common clock support, but Linus Walleij may have more
> details about what remains here.
>
> We should also make it possible to enable ARCH_VIRT for pre-ARMv7 to
> get qemu users to move over to that.

I think the main reason many people still use QEMU's versatilepb
model is that it has PCI. If you want people to move off that then
getting those "generic device-tree driven PCI" patches into the
kernel would probably be a good start :-)  At that point we can
reasonably easily add PCI support to the QEMU 'virt' board.

thanks
-- PMM
