From: davem@davemloft.net (David Miller)
Date: Wed, 18 Nov 2015 22:38:37 -0500 (EST)
Subject: [PATCH] arm64: bpf: fix buffer pointer
In-Reply-To: <1447836962-4086-1-git-send-email-zlim.lnx@gmail.com>
References: <1447836962-4086-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <20151118.223837.1209898089030584083.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zi Shen Lim <zlim.lnx@gmail.com>
Date: Wed, 18 Nov 2015 00:56:02 -0800

> During code review, I noticed we were passing a bad buffer pointer
> to bpf_load_pointer helper function called by jitted code.
> 
> Point to the buffer allocated by JIT, so we don't silently corrupt
> other parts of the stack.
> 
> Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>

Applied, thank you.
