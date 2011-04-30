From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 29 Apr 2011 20:28:47 -0400 (EDT)
Subject: [PATCH v5 5/8] arm/dt: Drop irq_create_of_mapping() from arm code.
In-Reply-To: <20110429071553.12522.65073.stgit@ponder>
References: <20110429070135.12522.35745.stgit@ponder>
	<20110429071553.12522.65073.stgit@ponder>
Message-ID: <alpine.LFD.2.00.1104292027560.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Grant Likely wrote:

> It is now implemented by core code.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/kernel/devtree.c |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)

Maybe this should be folded in the patch that introduced this instead?


Nicolas
