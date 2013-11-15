From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 15 Nov 2013 19:54:58 +0100
Subject: [PATCH v2 0/3] arm: [U]EFI runtime services support
In-Reply-To: <CAOesGMh+2Qs_cVMtdkpyXR44NJkQscs0eP_=pxwKXHkopaAKog@mail.gmail.com>
References: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
 <CAOesGMh+2Qs_cVMtdkpyXR44NJkQscs0eP_=pxwKXHkopaAKog@mail.gmail.com>
Message-ID: <20131115185458.GA30374@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Many thanks for having a look.

On Fri, Nov 15, 2013 at 10:04:22AM -0800, Olof Johansson wrote:
> This series is generally looking sane to me without looking at the
> code in very close detail.

In the interest of full disclosure, I would like to point out that I
will be posting another version next week, based on the output of the
discussions around the DT bindings and documentation.
 
This set needs to be tested in combination with Roy's UEFI stub patches
is recommended, as this is the intended boot mechanism on UEFI
platforms. https://wiki.linaro.org/LEG/Engineering/Kernel/UEFI/EFIstub

> Do you have a test setup that you've been using for this that you
> could give a pointer to?

Well, I have been using vexpress ca9 and ca15_a7 (TC2), or the ARM
commercial software models (RTSM) of the same. I have also tested on
Arndale, but I don't know if that is fully supported by mainline yet.

Prebuilt UEFI images are available from
http://releases.linaro.org/13.09/components/kernel/uefi-linaro

efibootmgr is probably the best utility to test the runtime services,
if scanning the /sys entries are not sufficient. It builds for armhf
without modification.

/
    Leif
