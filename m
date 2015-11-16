From: davem@davemloft.net (David Miller)
Date: Mon, 16 Nov 2015 14:39:27 -0500 (EST)
Subject: [PATCH 1/2] arm64: bpf: fix JIT frame pointer setup
In-Reply-To: <1447365421-1309-2-git-send-email-yang.shi@linaro.org>
References: <1447365421-1309-1-git-send-email-yang.shi@linaro.org>
 <1447365421-1309-2-git-send-email-yang.shi@linaro.org>
Message-ID: <20151116.143927.1891085632150496414.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Shi <yang.shi@linaro.org>
Date: Thu, 12 Nov 2015 13:57:00 -0800

> BPF fp should point to the top of the BPF prog stack. The original
> implementation made it point to the bottom incorrectly.
> Move A64_SP to fp before reserve BPF prog stack space.
> 
> CC: Zi Shen Lim <zlim.lnx@gmail.com>
> CC: Xi Wang <xi.wang@gmail.com>
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Applied.
