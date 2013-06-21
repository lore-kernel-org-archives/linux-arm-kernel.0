From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jun 2013 16:19:16 +0530
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <3686094.n3OCaPGG8M@wuerfel>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306181609.14966.arnd@arndb.de> <51C06D19.3020304@linaro.org>
 <3686094.n3OCaPGG8M@wuerfel>
Message-ID: <20130621104916.GI23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 05:08:01PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 June 2013 22:22:17 zhangfei wrote:
> > > With no need to have a filter function.
> > 
> > Cool, then I would like to wait for the patch.
> 
> Maybe you can try to add the dma_get_slave_channel() function I proposed here
> as a first patch and add your driver on top. There may be issues I missed,
> and Vinod needs to agree to the concept first, but that would probably
> get his attention.
You have it now :)


> 
> Or you could send your the new interface as an add-on patch
> and convert your driver along with adding it.
patch is always welcome

--
~Vinod
