From: vkoul@kernel.org (Vinod)
Date: Mon, 9 Jul 2018 22:57:29 +0530
Subject: [PATCH] dma: stm32: replace "%p" with "%pK"
In-Reply-To: <20180706130220.21957-1-benjamin.gaignard@st.com>
References: <20180706130220.21957-1-benjamin.gaignard@st.com>
Message-ID: <20180709172729.GO22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-07-18, 15:02, Benjamin Gaignard wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

The subsystem name is 'dmaengine' and not dma.
The git log on the subsystem should have told you this

Applied after fixing the tag, thanks.
-- 
~Vinod
