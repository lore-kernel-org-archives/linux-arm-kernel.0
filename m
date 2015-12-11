From: horms@verge.net.au (Simon Horman)
Date: Sat, 12 Dec 2015 08:07:48 +0900
Subject: [PATCH 1/3] arm64: dts: r8a7795: Add PSCI node
In-Reply-To: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <20151211230748.GC6496@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 02:38:51PM +0100, Dirk Behme wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> Add PSCI node for r8a7795 SoC, and cpu node enable-method property is
> set to "psci".
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>

I took the liberty of correcting the spelling of "Sigend" when
queueing this patch up for v4.5.
