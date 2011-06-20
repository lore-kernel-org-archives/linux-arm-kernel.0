From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 13:20:32 +0100
Subject: [PATCH 1/2] config: omap2+: force fb and dss support as built-in
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D625A5C@dbde02.ent.ti.com>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
	<1308566761-2850-2-git-send-email-tushar.behera@linaro.org>
	<B85A65D85D7EB246BE421B3FB0FBB593024D625A5C@dbde02.ent.ti.com>
Message-ID: <20110620122032.GJ2082@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 05:37:07PM +0530, Premi, Sanjeev wrote:
> [sp] Instead of changing the omap2plus_defconfig, shouldn't the
>      board specific file be fixed instead?

The board specific configuration files in the mainline kernel are
deprecated and are gradually being removed.
