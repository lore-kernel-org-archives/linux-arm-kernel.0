From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Jun 2015 15:20:37 +0200
Subject: [PATCH v3 10/11] KVM: arm: add a trace event for cp14 traps
In-Reply-To: <1434969694-7432-11-git-send-email-zhichao.huang@linaro.org>
References: <1434969694-7432-1-git-send-email-zhichao.huang@linaro.org>
 <1434969694-7432-11-git-send-email-zhichao.huang@linaro.org>
Message-ID: <20150630132037.GW11332@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 06:41:33PM +0800, Zhichao Huang wrote:
> There are too many cp15 traps, so we don't reuse the cp15 trace event
> but add a new trace event to trace the access of debug registers.
> 
> Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
