From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 08 Aug 2016 16:46:21 -0700
Subject: [PATCH v2 06/22] usb: chipidea: Add platform flag for wrapper phy
 management
In-Reply-To: <20160806075925.GC12298@shlinux2>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-7-stephen.boyd@linaro.org>
 <20160708092535.GD20485@shlinux2>
 <147043356053.26915.10086819023294264100@sboyd-linaro>
 <20160806075925.GC12298@shlinux2>
Message-ID: <147069998158.10825.8595816732650723884@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-08-06 00:59:25)
> On Fri, Aug 05, 2016 at 02:46:00PM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-07-08 02:25:35)
> > > 
> > > How you handle the code for PHY getting at probe?
> > > 
> > 
> > Which probe? Glue layer probe? In my case I'm not using the phy until
> > the RESET/STOPPED event so I just rely on the chipidea core to get the
> > phy and then control the phy manually in the glue layer.
> 
> I have no idea about it after reading your patch 10/22.
> 

Sorry, you lost me now. What is the question?
