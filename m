From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 27 Oct 2012 20:20:03 -0600
Subject: [PATCH 1/3] irqchip: add basic infrastructure
In-Reply-To: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508C9653.8010901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2012 10:45 AM, Thomas Petazzoni wrote:
...
> So, upon the suggestion of Rob Herring and Arnd Bergmann, this commit
> introduces a small infrastructure that defines a central
> irqchip_init() function in drivers/irqchip/irqchip.c, which is meant
> to be called as the ->init_irq() callback of ARM platforms.

This patch.
Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

As a minor aside, I only received patch 2/3 in my inbox initially, and
that made no sense to me without reading this patch too. It would have
been helpful to have been CC'd on the whole series.
