From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 26 Nov 2015 10:45:00 +0200
Subject: [RESEND v4 0/6] remoteproc: Add driver for STMicroelectronics
 platforms
In-Reply-To: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAK=WgbZbiq_BAUEti9tWUtWqZPU_4gDJ5Mfqur=Ou2N4Ea+2GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Nov 24, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> ST's platforms often have multiple co-processors (usually ST40s or ST231s)
> on-board.  This provides the Linux-side infrastructure to flash and boot
> them successfully.
>
> This set has been tested on an STiH410-B2120.

It would be nice if you could get at least one Reviewed-by tag coming
outside of ST (e.g., Suman or Bjorn who are actively using and
improving remoteproc).

>  arch/arm/boot/dts/stih407-family.dtsi              |  70 +++++

Since this is outside of remoteproc, please have it Acked, preferably
by ARM DT maintainer (Olof?).

Thanks,
Ohad.
