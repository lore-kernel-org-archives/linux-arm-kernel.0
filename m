From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 10:22:40 -0800
Subject: [PATCH 01/10] arm: omap4: fix kconfig warning
In-Reply-To: <1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20111222182240.GN24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)

Thanks applying into fixes-non-critical-part3.

Tony
