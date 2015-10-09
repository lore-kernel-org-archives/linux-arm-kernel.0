From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 9 Oct 2015 10:00:14 -0500
Subject: [PATCHv3 0/7] arm64: Use contiguous PTE bit for the kernel linear
 mapping
In-Reply-To: <20151009125052.GV17192@e104818-lin.cambridge.arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
 <20151009125052.GV17192@e104818-lin.cambridge.arm.com>
Message-ID: <5617D67E.8080607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2015 07:50 AM, Catalin Marinas wrote:

> I queued the series without patch 6 (and a modification of patch 7 to
> get rid of the config option check). If we need this option, we can add
> it later but for (hardware) debugging purposes it looks to me like we
> can simply set PTE_CONT to 0.

Sounds good to me.

Thanks,
