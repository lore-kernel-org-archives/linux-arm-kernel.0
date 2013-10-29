From: timur@tabi.org (Timur Tabi)
Date: Tue, 29 Oct 2013 08:00:44 -0500
Subject: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>,
 <526FAD41.2000805@tabi.org>
 <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>
Message-ID: <526FB17C.3090009@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Guangyu-B42378 wrote:
> Without dual fifo support,  handware underrun would occasionally
> occur and then two audio channels would physically swap. This could
> be easily reproduced in low bus frequency situation, while it would
> be better if we enable dual fifo.

Ok.

ACK.
