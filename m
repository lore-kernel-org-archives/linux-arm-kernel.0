From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Oct 2013 11:15:19 -0700
Subject: [PATCH] ARM: OMAP: remove deprecated IRQF_DISABLED
In-Reply-To: <1378538365-7353-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1378538365-7353-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <20131003181519.GR8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Michael Opdenacker <michael.opdenacker@free-electrons.com> [130907 00:27]:
> This patch proposes to remove the IRQF_DISABLED flag from OMAP code
> It's a NOOP since 2.6.35, and will be removed one day.

Thanks, applying into omap-for-v3.13/fixes-not-urgent.

Tony
