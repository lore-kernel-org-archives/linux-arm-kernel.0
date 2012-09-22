From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Sep 2012 23:08:17 -0700
Subject: [GIT PULL][for 3.7] pull request on dt2 branch from arch-pxa
In-Reply-To: <CAN1soZxC_KovdgENmsSQcUFkK2VgirkaKKSx1=RjLhULATw=+Q@mail.gmail.com>
References: <CAN1soZxC_KovdgENmsSQcUFkK2VgirkaKKSx1=RjLhULATw=+Q@mail.gmail.com>
Message-ID: <20120922060817.GJ32245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:24:58PM +0800, Haojian Zhuang wrote:
> Hi Olof & Arnd,
> 
> Please help to merge dt2 branch from arch-pxa git tree.
> 
> Regards
> Haojian
> 
> The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
> 
>   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hzhuang1/linux.git dt2
> 
> for you to fetch changes up to 37586e0b9cadd1072196c3cca8ea8559b91b1605:
> 
>   ARM: dt: mmp-dma: add binding file (2012-09-21 15:51:26 +0800)
> 
> ----------------------------------------------------------------
> Zhangfei Gao (1):
>       ARM: dt: mmp-dma: add binding file

What happened to the rest of this series? It makes more sense to merge the
driver using the binding at the same time as the binding itself, so let's hold
off until the driver is reviewed and ready to go in too (or, if you merge that
through a different path, the binding could/should go with it there).


-Olof
