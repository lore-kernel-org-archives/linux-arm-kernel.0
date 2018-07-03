From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Jul 2018 15:56:27 +0100
Subject: [PATCH 2/2] arm64: add support for 43bit physical address
In-Reply-To: <20180702210451.16057-2-nkela@cisco.com>
References: <20180702210451.16057-2-nkela@cisco.com>
Message-ID: <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:04:51PM -0700, Nikunj Kela wrote:
> This patch adds support for 43bit physical address. Additionally,
> this patch adds support for 27bit section size. This is useful in
> reducing kernel memory usage. One usecase is in kdump kernel.

Some numbers please.

-- 
Catalin
