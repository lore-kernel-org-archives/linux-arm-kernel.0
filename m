From: olof@lixom.net (Olof Johansson)
Date: Fri, 15 Nov 2013 10:04:22 -0800
Subject: [PATCH v2 0/3] arm: [U]EFI runtime services support
In-Reply-To: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
References: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <CAOesGMh+2Qs_cVMtdkpyXR44NJkQscs0eP_=pxwKXHkopaAKog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 3, 2013 at 4:24 AM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> In systems based on [U]EFI-conformant firmware, runtime services provide
> a standardised way for the kernel to update firmware environment
> variables. This is used for example by efibootmgr to update which image
> should be loaded on next boot.
>
> This patchset implements basic support for UEFI runtime services on ARM
> platforms, as well as the basic underlying EFI support. It also defines
> a mechanism by which the required information is passed from the
> bootloader to the kernel via FDT entries.
>
> This patchset depends on the previously submitted early_ioremap() and
> generic UEFI config table scanning patchsets.
>
> Changes from v1:
> - Updated FDT bindings, based on feedback.
> - Use common config table scanning and address lookup code.
> - Add dependency on !CPU_BIG_ENDIAN (for now).
> - Add proper efi_enabled() facility.
> - Documentation updates.

This series is generally looking sane to me without looking at the
code in very close detail.

Do you have a test setup that you've been using for this that you
could give a pointer to?


-Olof
