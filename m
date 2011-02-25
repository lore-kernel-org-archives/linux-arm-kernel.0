From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 25 Feb 2011 21:06:04 +0530
Subject: [PATCH] DA850 EVM: kill useless variable
In-Reply-To: <201102071845.37812.sshtylyov@ru.mvista.com>
References: <201102071845.37812.sshtylyov@ru.mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE49F47@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Feb 07, 2011 at 21:15:37, Sergei Shtylyov wrote:
> Commit 75e2ea643fe43d5aa836475acee5bd97cd9ea4bf (davinci: DA850/OMAP-L138 EVM
> expander setup and UI card detection) introduced a useless variable: it's
> always set to 1 before it's checked in da850_evm_setup_nor_nand()...

Added this patch in queue for 2.6.39. Added a "davinci: " prefix to
the subject line.

Thanks,
Sekhar
