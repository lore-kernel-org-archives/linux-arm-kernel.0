From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 22:03:37 +0000
Subject: [PATCH v3 3/5] clk: introduce the common clock framework
In-Reply-To: <alpine.DEB.2.00.1112011124221.6289@utopia.booyaka.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-4-git-send-email-mturquette@linaro.org>
 <alpine.DEB.2.00.1111291619110.6289@utopia.booyaka.com>
 <CAJOA=zM4vcyTt_RBEVm6JxmzW-Dna0gpuWda7ytq_mqFSuXw9g@mail.gmail.com>
 <alpine.DEB.2.00.1111302308280.6289@utopia.booyaka.com>
 <20111201144205.GA2103@sirena.org.uk>
 <alpine.DEB.2.00.1112011124221.6289@utopia.booyaka.com>
Message-ID: <20111201220337.GE19739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:30:16AM -0700, Paul Walmsley wrote:
> The intention behind the clk_{allow,block}_rate_change() proposal was to 
> allow the current user of the clock to change its rate without having to 
> call clk_{allow,block}_rate_change(), if that driver was the sole user of 
> the clock.

And how does a driver know that?
