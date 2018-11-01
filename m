From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 1 Nov 2018 23:19:13 +0200
Subject: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
In-Reply-To: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
Message-ID: <a253c416-44c2-23c6-65db-6d89d7f430a8@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 11/01/2018 07:32 PM, Martin Kaiser wrote:
> The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> function blocks. Add their ipg and per clocks to the device tree.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

the change is obviously correct.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
