From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Apr 2012 10:44:13 -0700
Subject: [GIT PULL] at91: 3.4-rc1 fixes
In-Reply-To: <4F7C7EDF.4000702@atmel.com>
References: <4F7C7EDF.4000702@atmel.com>
Message-ID: <CAOesGMiEBBiZ1Q3RjT=KxCR+kJWhoVPGdMRFPN=nObjZuvzgWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 10:03 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof,
>
> I would like you to integrate this fist batch of AT91 related fixes. They
> are covering DT and USB related issues that we have seen on top of 3.4-rc1.
>
> I have also included modifications of the OHCI USB driver because they
> are also touching the core AT91 devices/board files and Device Tree files.
> The modification of "vbus_pin_active_low" in particular cannot be separated
> from the modification of .dts[i] and devices/board files.
>
> Alan Stern for USB OHCI/EHCI and Grant Likely for DT gave me their "Acked-by"
> on concerned patches (thanks a lot guys!).
>
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
>
> ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
>
> are available in the git repository at:
>
> ?git://github.com/at91linux/linux-at91.git at91-fixes

Thanks, pulled.


-Olof
