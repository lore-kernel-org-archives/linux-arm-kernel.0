From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Nov 2011 15:15:01 -0700
Subject: [PATCH 1/1] arm: omap: removed obsolete IRQF_DISABLED
In-Reply-To: <1318139198-6865-2-git-send-email-michael.opdenacker@linaro.org>
References: <1318139198-6865-1-git-send-email-michael.opdenacker@linaro.org>
	<1318139198-6865-2-git-send-email-michael.opdenacker@linaro.org>
Message-ID: <20111103221501.GD31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Michael Opdenacker <michael.opdenacker@linaro.org> [111008 22:13]:
> This flag is a NOOP since 2.6.36

Looks like there's an ARM wide patch to do this with
"[PATCH 03/55] arm: irq: Remove IRQF_DISABLED".

Regards,

Tony
