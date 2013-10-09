From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Oct 2013 12:40:57 +0900
Subject: [PATCH v2 3/3] ARM: shmobile: kzm9d: Use common clock framework
In-Reply-To: <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
Message-ID: <20131009034057.GO15065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 02:34:03PM +0900, takasi-y at ops.dti.ne.jp wrote:
> Use common clock framework version of clock
>  drivers/clk/shmobile/clk-emev2.c
> instead of sh-clkfwk version
>  arch/arm/mach-shmobile/clock-emev2.c
> when it is configured as a part of multi-platform.
> 
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Thanks.

I plan to add this patch to a new topic branch,
topic/emev2-common-clock, in the renesas tree and
queue it up from there for inclusion in mainline
if/when the first patch of this series is accepted
by Mike Turquette.
