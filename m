From: daniel@iogearbox.net (Daniel Borkmann)
Date: Fri, 13 Jul 2018 15:30:52 +0200
Subject: [PATCH net-next 0/4] Further ARM BPF jit compiler improvements
In-Reply-To: <20180712205003.GU17271@n2100.armlinux.org.uk>
References: <20180712205003.GU17271@n2100.armlinux.org.uk>
Message-ID: <7bd03f32-2c7f-2f7c-0248-9b199eb0bc40@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2018 10:50 PM, Russell King - ARM Linux wrote:
> Four further jit compiler improves for 32-bit ARM.
> 
>  arch/arm/net/bpf_jit_32.c | 120 ++++++++++++++++++++++++++++------------------
>  1 file changed, 73 insertions(+), 47 deletions(-)

Applied to bpf-next, thanks Russell! (Fyi, pull-req with the two sets included will
go out to David Miller for net-next later today.)
