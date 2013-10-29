From: B42378@freescale.com (Chen Guangyu-B42378)
Date: Tue, 29 Oct 2013 13:03:26 +0000
Subject: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <526FB17C.3090009@tabi.org>
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>,
 <526FAD41.2000805@tabi.org>
 <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>,
 <526FB17C.3090009@tabi.org>
Message-ID: <uq0wlfsid450p3ufwptuuscw.1383051812670@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you, sir. And sorry for taking your time.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Chen Guangyu-B42378 wrote:
> Without dual fifo support,  handware underrun would occasionally
> occur and then two audio channels would physically swap. This could
> be easily reproduced in low bus frequency situation, while it would
> be better if we enable dual fifo.

Ok.

ACK.
