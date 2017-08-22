From: davem@davemloft.net (David Miller)
Date: Tue, 22 Aug 2017 09:28:15 -0700 (PDT)
Subject: [PATCH net-next v4] arm: eBPF JIT compiler
In-Reply-To: <1503383553-5650-1-git-send-email-illusionist.neo@gmail.com>
References: <1503383553-5650-1-git-send-email-illusionist.neo@gmail.com>
Message-ID: <20170822.092815.433603069354349639.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubham Bansal <illusionist.neo@gmail.com>
Date: Tue, 22 Aug 2017 12:02:33 +0530

> The JIT compiler emits ARM 32 bit instructions. Currently, It
> supports eBPF only. Classic BPF is supported because of the
> conversion by BPF core.
 ...

Applied to net-next, thanks.
