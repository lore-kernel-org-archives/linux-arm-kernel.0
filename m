From: jcm@jonmasters.org (Jon Masters)
Date: Tue, 11 Apr 2017 00:40:09 -0400
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <CAPub14-sFgx=oCHzJPb9h9b_V0rbn5UAMDNJ-yTkjhz38JPqMQ@mail.gmail.com>
 <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
 <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
 <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
Message-ID: <5d1fc066-d551-31cf-51bc-8fb17d7e2ec3@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2017 11:58 AM, Catalin Marinas wrote:

> The Cavium guys haven't shown any numbers (IIUC) to back the
> L1_CACHE_BYTES performance improvement but I would not revert the
> original commit since ARCH_DMA_MINALIGN definitely needs to cover the
> maximum available cache line size, which is 128 for them.

I am pinging them via other channels to ensure they've seen this.

Jon.
