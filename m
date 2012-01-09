From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 9 Jan 2012 23:02:25 +0800
Subject: [PATCH v4 2/2] dma/imx-sdma: convert _raw_readl/_raw_writel to
 readl/writel
In-Reply-To: <20120109144627.GR21765@n2100.arm.linux.org.uk>
References: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
 <1326033862-25351-3-git-send-email-richard.zhao@linaro.org>
 <20120109115143.GL21765@n2100.arm.linux.org.uk>
 <20120109142125.GA1854@richard-laptop>
 <20120109144627.GR21765@n2100.arm.linux.org.uk>
Message-ID: <20120109150222.GB2386@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 02:46:27PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 09, 2012 at 10:21:28PM +0800, Richard Zhao wrote:
> > Freescale power pc also has sdma, I guess we can use _relaxed till they
> > tend to use the same driver ( I don't know when).
> 
> The answer to that is to persuade powerpc to gain the _relaxed versions
> (which can simply call the non-relaxed versions as a first stab.)  They
> have the readx_relaxed() stuff already.
quite right.

Thanks
Richard
