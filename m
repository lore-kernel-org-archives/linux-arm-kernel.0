From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 22:24:32 -0700
Subject: [PATCH 2/2] ARM: allow for ATAGS to be configured out when DT
 support is selected
In-Reply-To: <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
References: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
 <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20120905052432.GH6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 05:10:08PM -0400, Nicolas Pitre wrote:
> Now that ATAGS support is well contained, we can easily remove it from
> the kernel build if so desired.  It has to explicitly be disabled, and
> only when DT support is selected.
> 
> Note: disabling kernel ATAGS support does not prevent the usage of
> CONFIG_ARM_ATAG_DTB_COMPAT.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Nice!

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
