From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 11 Jun 2018 18:04:34 -0700
Subject: [GIT PULL 2/4] ARM: Device-tree updates
In-Reply-To: <20180612000142.28883-3-olof@lixom.net>
References: <20180612000142.28883-1-olof@lixom.net>
 <20180612000142.28883-3-olof@lixom.net>
Message-ID: <CA+55aFy2sOHqcO-6LaKOZ5omyAow15gq+=Z7aOTZisrDihoecw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 5:02 PM Olof Johansson <olof@lixom.net> wrote:
>
> - Qualcomm:
> + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
> (Cortex-A75/A55 derivative) SoC that's one of the current high-end
> mobile SoCs.
>
> It's great to see mainline support for it. So far, you
> can't do much with it, since a lot of peripherals are not yet in the
> DTs but driver support for USB, GPU and other pieces are starting to
> trickle in. This might end up being a well-supported SoC upstream if
> the momentum keeps up.

Isn't the Qualcomm 845 also the SoC in some of the new WARM laptops?

I asked one person that had an older one (ASUS NovaGo - Qualcomm 835),
and apparently you can actually disable secure boot on that thing and
boot from USB.

In other words, it might _actually_ act like a normal laptop.

I'd love to have something that is actually a real honest-to-goodness
ARM laptop finally. Are we getting at all close to that?

                    Linus
