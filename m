From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 01 Mar 2013 09:39:30 -0800
Subject: [PATCH 0/2] gpio/omap: updates for v3.10
In-Reply-To: <1362158568-1624-1-git-send-email-jon-hunter@ti.com> (Jon
 Hunter's message of "Fri, 1 Mar 2013 11:22:46 -0600")
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Message-ID: <874ngv2f59.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Hunter <jon-hunter@ti.com> writes:

> Summary of updates:
> - Convert OMAP GPIO driver to use linear mapping for IRQ domains
> - Avoid crashes seen if a gpio bank is not enabled when requesting an IRQ.

Acked-by: Kevin Hilman <khilman@linaro.org>
