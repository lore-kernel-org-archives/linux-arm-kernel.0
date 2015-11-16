From: daniel@iogearbox.net (Daniel Borkmann)
Date: Mon, 16 Nov 2015 20:45:37 +0100
Subject: [PATCH] bpf, arm64: start flushing icache range from header
In-Reply-To: <20151116.144216.8808948219258398.davem@davemloft.net>
References: <41c4a481eb665a492c3b2df16af219b1250224a0.1447446460.git.daniel@iogearbox.net>
 <20151116.144216.8808948219258398.davem@davemloft.net>
Message-ID: <564A3261.4010400@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 08:42 PM, David Miller wrote:
...
> I'm applying this directly, please CC: netdev on future patches
> to the BPF JIT's regardless of where you think the patch will
> be applied as it should be _REVIEWED_ on netdev regardless.

Okay, sorry about that, will do in future.

Thanks, Dave!
