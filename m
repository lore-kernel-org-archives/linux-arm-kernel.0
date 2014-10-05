From: shijie.huang@intel.com (Huang Shijie)
Date: Sun, 5 Oct 2014 10:13:36 +0800
Subject: [PATCH v3 0/3] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20140930100720.45625804@bbrezillon>
References: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140930100720.45625804@bbrezillon>
Message-ID: <20141005021335.GA14640@shldeISGChi005.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 10:07:20AM +0200, Boris Brezillon wrote:
> Hi,
> 
> On Tue, 23 Sep 2014 16:07:33 +0200
> Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
> 
> > Hello Huang, Brian,
> > 
> > This is just a new proposal to support raw accesses in a more standard way
> > in the GPMI driver.
> > This series has been tested on an imx28 board.
> > 
> > Any suggestions are welcome.
> 
> Brian, any chance you could take a look at this series and give your
> opinion and/or suggest a new approach ?
> 
> Huang, did you have time to think about a better way to implement these
> raw access functions ?
> 
sorry for the later reply. I was busy recently.
You can send out the new version. Please do not forget add a patch to
add
more comments for these hooks.

I will test your patch(or your new patch set) on Oct 7 and Oct 8.

thanks
Huang Shijie
