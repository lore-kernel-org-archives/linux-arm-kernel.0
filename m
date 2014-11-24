From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 15:06:21 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: add driver support for hix5hd2
In-Reply-To: <1416750822-26305-1-git-send-email-zhangfei.gao@linaro.org>
References: <1416750822-26305-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <37901649.5ex6yEbcJj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014 21:53:42 Zhangfei Gao wrote:
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig |    7 +++++++
>  1 file changed, 7 insertions(+)
> 

The patch looks good, but the changeset description is missing.

- What level of testing has been done on this (compile, boot, some
  testsuite, ...)?

- What do you expect to happen with the patch? Do you want review
  or should someone pick it up?

	Arnd
