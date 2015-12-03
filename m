From: davem@davemloft.net (David Miller)
Date: Thu, 03 Dec 2015 11:38:46 -0500 (EST)
Subject: [RESEND PATCH] arm64: bpf: add 'store immediate' instruction
In-Reply-To: <1448922247-5692-1-git-send-email-yang.shi@linaro.org>
References: <1448922247-5692-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20151203.113846.853547663758521483.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Shi <yang.shi@linaro.org>
Date: Mon, 30 Nov 2015 14:24:07 -0800

> aarch64 doesn't have native store immediate instruction, such operation
> has to be implemented by the below instruction sequence:
> 
> Load immediate to register
> Store register
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Applied, thanks.
