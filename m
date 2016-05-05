From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 May 2016 18:25:52 +0100
Subject: [PATCH v2 3/8] arm64: add io{read,write}64be accessors
In-Reply-To: <1462462564-27731-1-git-send-email-horia.geanta@nxp.com>
References: <1462462435-27403-1-git-send-email-horia.geanta@nxp.com>
 <1462462564-27731-1-git-send-email-horia.geanta@nxp.com>
Message-ID: <20160505172551.GG3703@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 06:36:04PM +0300, Horia Geant? wrote:
> This will allow device drivers to consistently use io{read,write}XXbe
> also for 64-bit accesses.
> 
> Signed-off-by: Alex Porosanu <alexandru.porosanu@nxp.com>
> Signed-off-by: Horia Geant? <horia.geanta@nxp.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
