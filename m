From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 12:45:45 -0800
Subject: [PATCH 01/10] arm: omap4: fix kconfig warning
In-Reply-To: <CAMP44s2MfdS-woETebYsTHEPZsBuBpP2dfmfBibC+JWZZ2iLKQ@mail.gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
 <20111222182240.GN24444@atomide.com>
 <CAMP44s2MfdS-woETebYsTHEPZsBuBpP2dfmfBibC+JWZZ2iLKQ@mail.gmail.com>
Message-ID: <20111222204545.GT24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [111222 11:37]:
> On Thu, Dec 22, 2011 at 8:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> >> warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)
> >
> > Thanks applying into fixes-non-critical-part3.
> 
> Actually, please disregard this one, it should be handled by this:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/141942

OK dropping.

Tony
