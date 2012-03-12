From: dwalker@fifo99.com (Daniel Walker)
Date: Mon, 12 Mar 2012 13:14:21 -0700
Subject: [PATCH v3 2/2] DMAEngine: Add DMAEngine driver based on old MSM
 DMA APIs
In-Reply-To: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
References: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
Message-ID: <20120312201421.GA3459@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 04:02:44PM +0530, Ravi Kumar V wrote:
> Add DMAEngine based driver using the old MSM DMA APIs internally.

What do you mean by this?

> The benefit of this approach is that not all the drivers
> have to get converted to DMAEngine APIs simultaneosly while
> both the drivers can stay enabled in the kernel. The client
> drivers using the old MSM APIs directly can now convert to
> DMAEngine one by one.

Which drivers?

Daniel
