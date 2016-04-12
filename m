From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Apr 2016 08:27:17 +0100
Subject: [PATCH v2 0/5] mailbox: A few fixes due for the v4.6 -rcs
In-Reply-To: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
References: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412072717.GG8094@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Mar 2016, Lee Jones wrote:

> Hi Jassi,
> 
> Resending these with patches 1 and 2 merged, as requested.

Jassi,

Not heard anything from you in quite some time now.

> Kind regards,
> Lee
> 
> v1 => v2:
>   - Patch 2 merged into patch 
>   - No functional changes
> 
> Lee Jones (5):
>   ARM: STi: stih407-family: Add nodes for Mailbox
>   ARM: STi: DT: STiH407: Enable Mailbox testing facility
>   mailbox: mailbox-test: Use more consistent format for calling
>     copy_from_user()
>   mailbox: mailbox-test: Prevent memory leak
>   mailbox: Stop using ENOSYS for anything other than unimplemented
>     syscalls
> 
>  arch/arm/boot/dts/stih407-family.dtsi | 39 +++++++++++++++++++++++++++++++++++
>  drivers/mailbox/mailbox-test.c        | 16 +++++++-------
>  drivers/mailbox/mailbox.c             |  4 ++--
>  3 files changed, 50 insertions(+), 9 deletions(-)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
