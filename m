From: daniel@iogearbox.net (Daniel Borkmann)
Date: Wed, 29 Apr 2015 18:37:32 +0200
Subject: [PATCH 0/4] Seccomp filter JIT support on ARM.
In-Reply-To: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
Message-ID: <554108CC.6000801@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 03:37 PM, Nicolas Schichan wrote:
...
> The fourth and final patch fixes a bug in the emit_udiv() function
> when used to convert a BPF_ALU | BPF_DIV | BPF_K instruction in the
> ARM BPF JIT code.

Shouldn't that fix go separately, so it can be included into 4.1
resp. -stable?

Would be good if you also Cc Mircea, who wrote the code. Was that
caught by lib/test_bpf.c suite (if not, would be good to add a test
case for it) ?
