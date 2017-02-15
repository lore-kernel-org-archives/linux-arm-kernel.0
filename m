From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Feb 2017 19:35:36 +0000
Subject: [PATCH v2 0/5] ARM: add module autoloading support for crypto
 modules
In-Reply-To: <CAKv+Gu_dLm5iKWbt3C5snjRayedvu9QHpC9oOS=+OPASRgnmOA@mail.gmail.com>
References: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9q5sH2_=3TZNbPAf3fdFB=F7Ut5swnp7qiUgwbuqemnA@mail.gmail.com>
 <CAKv+Gu9XSjprPBHqHvTQhJ-ChXeFjVQ1K0LPNcTvru6TgUEBDA@mail.gmail.com>
 <CAKv+Gu9DFFM6LEKxs5E9jugfRj4CKHb-5nVoD4uzrjmbvk9rGg@mail.gmail.com>
 <20170215192425.GD27312@n2100.armlinux.org.uk>
 <CAKv+Gu_dLm5iKWbt3C5snjRayedvu9QHpC9oOS=+OPASRgnmOA@mail.gmail.com>
Message-ID: <20170215193536.GE27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 07:29:39PM +0000, Ard Biesheuvel wrote:
> On 15 February 2017 at 19:24, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Feb 15, 2017 at 05:16:47PM +0000, Ard Biesheuvel wrote:
> >> On 31 January 2017 at 13:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> > On 19 January 2017 at 18:23, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> >> On 11 January 2017 at 17:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> >>> This series wires up the crypto modules that use the ARM 32-bit versions of
> >> >>> the ARMv8 Crypto Extensions to udev autoloading, by exposing the HWCAP2
> >> >>> feature bits via the CPU modalias. This is very similar to the arm64
> >> >>> implementation, with the notable exception that ARM has its CPU feature
> >> >>> definitions split across HWCAP and HWCAP2.
> >> >>>
> >> >>> Given that the crypto feature bits are all exposed via HWCAP2, and considering
> >> >>> that there are currently no features exposed via HWCAP that are relevant to
> >> >>> udev module autoloading, exposing HWCAP2 only should be sufficient, at least
> >> >>> for now.
> >> >>>
> >> >>> Changes since v1:
> >> >>> - rebase onto v4.10-rc2
> >> >>>
> >> >>> Ard Biesheuvel (5):
> >> >>>   ARM: wire up HWCAP2 feature bits to the CPU modalias
> >> >>
> >> >> Ping?
> >> >>
> >> >
> >> > Ping?
> >>
> >> Ping?
> >
> > Sorry, but whom are you pinging?
> >
> 
> You. This is something you were going to look at, then couldn't find
> the email and asked me to resend, which I did.
> 
> http://marc.info/?l=linux-crypto-vger&m=147678795532341&w=2
> http://marc.info/?l=linux-arm-kernel&m=148415420105771

Right, I'd forgotten, and as it wasn't sent _TO_ me, I wasn't paying
attention.  If you want me to do something, then always send _TO_ me.
Don't just CC me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
