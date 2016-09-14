From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Sep 2016 19:15:59 +0530
Subject: [PATCH 1/2 v3] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <8760pyd41s.fsf@free-electrons.com>
References: <20160905072500.30112-1-sr@denx.de>
 <8760pyd41s.fsf@free-electrons.com>
Message-ID: <20160914134559.GM13920@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 03:06:07PM +0200, Gregory CLEMENT wrote:
> Hi,
>  
>  On lun., sept. 05 2016, Stefan Roese <sr@denx.de> wrote:
> 
> > This patch provides a stub function for mvebu_mbus_get_io_win_info(),
> > which will be used for all non-Orion (ARM32 MVEBU) platforms for
> > compile test coverage.
> >
> > On such platforms this function will return an error so that drivers
> > might detect a potential problem.
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Vinod, if you happy with the second patch of the series you can apply
> both patches on your tree. It will allow to keep the bisactibility, and
> as I didn't have any commit modifying these file in my trees it won't
> generate merge conflict.

Okay, somehow I dont see this in my queue. Can you guys pls resend.

Thanks
-- 
~Vinod
