From: davem@davemloft.net (David Miller)
Date: Sun, 11 Jun 2017 18:18:53 -0400 (EDT)
Subject: [PATCH net-next] bpf, arm64: take advantage of stack_depth
 tracking
In-Reply-To: <afc90487fc573886a44178c2428f3157312128d8.1497145004.git.daniel@iogearbox.net>
References: <afc90487fc573886a44178c2428f3157312128d8.1497145004.git.daniel@iogearbox.net>
Message-ID: <20170611.181853.19339299534970449.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sun, 11 Jun 2017 03:55:27 +0200

> Make use of recently implemented stack_depth tracking for arm64 JIT,
> so that stack usage can be reduced heavily for programs not using
> tail calls at least.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks Daniel.
