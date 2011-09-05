From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 05 Sep 2011 18:44:52 +0530
Subject: [PATCH 0/6] Add device tree support for PL330 dma controller
	driver
In-Reply-To: <CAJuYYwQCdWjEzAeO-Gm2GTKO3_ocSOx8sZeBQP-7Y=GbHf=5vQ@mail.gmail.com>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314638947.1606.157.camel@vkoul-udesk3>
	<CAJuYYwQCdWjEzAeO-Gm2GTKO3_ocSOx8sZeBQP-7Y=GbHf=5vQ@mail.gmail.com>
Message-ID: <1315228492.26251.76.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-30 at 17:58 +0530, Thomas Abraham wrote:
> Hi Vinod,
> 
> On 29 August 2011 22:59, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> > On Fri, 2011-08-26 at 14:10 +0530, Thomas Abraham wrote:
> >> This patchset adds device tree support for PL330 driver and uses it
> >> to add device tree support for Samsung platforms, specifically Exynos4.
> > The DMA patches looks good to me. Do you want this to go thru slave-dma
> > tree or somewhere else.
> > I will need acks on 3, 5 and 6th patch to carry them.
> 
> There are couple of changes required in patch 4/6 of this series. I
> will do that and resubmit.
> 
> Since these patches are based on Boojin's pl330 driver update patches,
> it would be easier to take the same route which Boojin's patches will
> take. I will try to get acks' for the patches that you have listed.
> 
And I think these might need to be rebased based on Boojin's latest
version

-- 
~Vinod
