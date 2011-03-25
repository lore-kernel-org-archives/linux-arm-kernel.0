From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 25 Mar 2011 20:30:14 +0300
Subject: [PATCH] OMAP: iovmm: fix SW flags passed by user
In-Reply-To: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com>
References: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <4D8CD126.6000405@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Omar Ramirez Luna wrote:

> Commit d038aee24dcd changes iovmm to receive flags specified by user,

    Please also specify that commit's summary for the human readers. Bare ID is 
only usable to gitweb...

> however the upper 16 bits of the flags are wiped by iovmm itself.

> This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
> map its desired "device addresses".

> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

WBR, Sergei
