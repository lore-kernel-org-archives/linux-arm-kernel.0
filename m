From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 11 Apr 2017 17:33:59 +0400
Subject: [PATCH v7 resend 00/20] ILP32 for ARM64
In-Reply-To: <20170411113334.GA27857@e104818-lin.cambridge.arm.com>
References: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
 <20170410194740.GA28503@yury-N73SV>
 <20170411113334.GA27857@e104818-lin.cambridge.arm.com>
Message-ID: <20170411133359.GA5091@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 12:33:35PM +0100, Catalin Marinas wrote:
> On Mon, Apr 10, 2017 at 11:47:40PM +0400, Yury Norov wrote:
> > According to latest plans figured out on Linaro Connect, ILP32 should
> > be taken in 4.12 merge window.
> 
> Sorry, I wasn't present at Linaro Connect, so definitely not involved in
> such decision.
> 
> BTW, it would be nice to have Arnd's ack on patch 2 (32-bit ABI:
> introduce ARCH_32BIT_OFF_T config option).

He already acked it, but after some rebase I lost that line
http://lists-archives.com/linux-kernel/28471253-32-bit-abi-introduce-arch_32bit_off_t-config-option.html

Yury
