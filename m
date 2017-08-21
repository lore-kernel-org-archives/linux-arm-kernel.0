From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Aug 2017 22:03:56 +0530
Subject: [PATCH 1/2] dmaengine: at_xdmac: Fix compilation warning.
In-Reply-To: <878f9486ee507c227cb8835417c520b489c768c8.1502091778.git.arvind.yadav.cs@gmail.com>
References: <878f9486ee507c227cb8835417c520b489c768c8.1502091778.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170821163355.GS3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 01:15:18PM +0530, Arvind Yadav wrote:
> Replace '%d' by '%zu' to fix the compilation warning:-
>    "format ?%d? expects argument of type ?int?,but argument has type ?size_t? [-Wformat=]"

Applied both, thanks

-- 
~Vinod
