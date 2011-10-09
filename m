From: michael.opdenacker@linaro.org (Michael Opdenacker)
Date: Sun,  9 Oct 2011 07:46:37 +0200
Subject: [PATCH 0/1] arm: omap: remove obsolete IRQF_DISABLED 
Message-ID: <1318139198-6865-1-git-send-email-michael.opdenacker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all occurrences of IRQF_DISABLED in the OMAP tree.
This flag is deprecated and obsolete and as IRQ handlers now run
with all interrupts disabled since 2.6.36
