From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 23 Jan 2018 15:11:50 +0800
Subject: [PATCH v2] ARM: dts: ls1021a: add nodes for on-chip ram
In-Reply-To: <1514994345-2471-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1513870698-31264-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1514994345-2471-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <20180123071149.GC27764@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 04:45:45PM +0100, Rasmus Villemoes wrote:
> Although the two nodes constitute one contiguous 128K region, still
> describe them separately:
> 
> - That's how they are described in the reference manual: "Each OCRAM
>   occupies a 64 KB of address region...", and the names ocram1 and
>   ocram2 are also as used in the manual.
> 
> - The two areas are treated differently by the boot ROM code: OCRAM2 is
>   zero-initialized, while, again quoting the RM, "software must perform
>   the zero initialization of OCRAM1."
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Applied, thanks.
