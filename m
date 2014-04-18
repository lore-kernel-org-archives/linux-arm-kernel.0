From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 18 Apr 2014 14:06:39 +0800
Subject: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
In-Reply-To: <20140417133359.GB31034@kwain>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
 <534E92FE.8010400@gmail.com> <20140417133359.GB31034@kwain>
Message-ID: <20140418140639.03c450f3@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 17 Apr 2014 06:33:59 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Sebastian,
> 
> On Wed, Apr 16, 2014 at 04:26:06PM +0200, Sebastian Hesselbarth wrote:
> > On 04/16/2014 02:40 PM, Antoine T?nart wrote:
> > >Add a Driver to support the SDHCI controller of the Marvell Berlin SoCs.
> > >This controller supports 3 sockets.
> > 
> > nit: Isn't it three controller with one socket each?
> 
> It's a little bit confusing, there are 3 different register regions and
> I can see 3 separate data lines but, I quote: "The SD host controller
> supports three sockets".
> 
> Maybe Jisheng can advise on that matter ?


It's three controller with one socket each ;)

Thanks
