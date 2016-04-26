From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 09:19:48 +0530
Subject: [PATCH v5 1/3] dmaengine: sun6i: Simplify lli setting
In-Reply-To: <6cf3432833a8b36acff526f949050d07de7a7a05.1461307982.git.moinejf@free.fr>
References: <cover.1461307982.git.moinejf@free.fr>
 <6cf3432833a8b36acff526f949050d07de7a7a05.1461307982.git.moinejf@free.fr>
Message-ID: <20160426034947.GH2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 08:47:29AM +0200, Jean-Francois Moine wrote:
> Checking the DMA config before setting the lli list avoids to do tests
> inside the setting loop.

Applied, thanks

-- 
~Vinod
