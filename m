From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 5 Oct 2017 14:00:22 +0100
Subject: [RESEND][PATCH 5/7] nvmem: imx-ocotp: Add i.MX7D timing write
 clock setup support
In-Reply-To: <1507200763.8473.12.camel@pengutronix.de>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
 <1507155921-824-6-git-send-email-pure.logic@nexus-software.ie>
 <1507200763.8473.12.camel@pengutronix.de>
Message-ID: <6b6d7832-692d-a729-3fa8-734e3f362694@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/17 11:52, Philipp Zabel wrote:
> Do we expect this to grow more different cases in the future?

Grow - I'm not so sure. Change definitely there's at least one other 
type of MX7 (which I don't have) that doesn't require a clock setup here 
at all.

> 
> Maybe it would be better to just store a .set_timing function pointer in
> the params.

Good idea.

Thanks for the reviews.

---
bod
