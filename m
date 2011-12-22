From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 10:23:13 -0800
Subject: [PATCH 04/10] arm: omap2: fix regulator warnings
In-Reply-To: <1324341747-5922-5-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-5-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20111222182313.GP24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MACH_OMAP_4430SDP && MACH_OMAP4_PANDA && TPS6105X) selects REGULATOR_FIXED_VOLTAGE which has unmet direct dependencies (REGULATOR)

Thanks applying into fixes-non-critical-part3.

Tony
