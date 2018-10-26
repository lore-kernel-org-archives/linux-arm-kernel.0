From: open.sudheer@gmail.com (sudheer.v)
Date: Fri, 26 Oct 2018 12:53:16 +0530
Subject: [[PATCH] 0/9] *** DMA support for UART in ASPEED's AST2500  ***
In-Reply-To: <20181025144841.GA21004@bogus>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <20181025144841.GA21004@bogus>
Message-ID: <20181026072314.GB30088@Pilot130>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 09:48:41AM -0500, Rob Herring wrote:
> On Wed, Oct 17, 2018 at 09:40:57AM +0530, sudheer.v wrote:
> > DMA controller driver  and UART dma client driver for aspeed's AST2500
> > 
> > sudheer.v (9):
> 
> We need a full name for author and Signed-off-by.
> 
> >   DT-changes-for-DMA-UART-of-AST2500
> >   Defconfig-changes-for-DMA-UART-of-AST2500
> >   configuration-for-DMA-of-AST2500
> >   Documentation-DTbindings-DMA-controller-of-AST2500
> >   DMA-driver-for-AST2500
> >   configuration-for-DMA-UART-of-AST2500
> >   Documentation-DTbindings-DMA-UART-of-AST2500
> >   DMA-UART-Driver-for-AST2500
> >   updating MAINTAINERS for DMA and DMA-UART drivers of AST2500
> 
> Your commit messages need some work. Use 'git log --oneline <dir>' on 
> each directory for inspiration as to what the subject should be.
> 
> DT bindings specifically are "dt-bindings: <binding dir>: ..."
> 
> Rob
Hi Rob,
As per the comments given by vinod and Ben,
we are planning to resubmit the patches, after merging these 
two drivers (dma and uart) into single driver.
While resubmitting, will ensure patches are formatted with
proper messages, following the convention.
Regards
Sudheer
