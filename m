From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 20:06:13 +0800
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <504F2872.8080609@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
 <20120907022711.GE26709@S2101-09.ap.freescale.net>
 <50495DB9.5030008@wwwdotorg.org>
 <20120907023955.GG26709@S2101-09.ap.freescale.net>
 <504F2872.8080609@gmail.com>
Message-ID: <20120911120610.GC2481@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 07:02:58AM -0500, Rob Herring wrote:
> Are you okay if I change i.MX entries to use CONFIG_ARCH_MXC instead of
> per SOC entries? I want to make things more consistent and primarily use
> the top level CONFIG_ARCH_xxx values.
> 
Yes, I'm okay with that.

-- 
Regards,
Shawn
