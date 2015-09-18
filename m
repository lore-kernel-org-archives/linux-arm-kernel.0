From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 18 Sep 2015 08:46:14 +0100
Subject: [PATCH] arm/ls1021a: Add Sleep feature for ls1021
In-Reply-To: <SN1PR0301MB1616F01085CC4549FFE3A1469D590@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1441877796-32232-1-git-send-email-dongsheng.wang@freescale.com>
 <20150910095920.GB29293@leverpostej>
 <SN1PR0301MB161620AA4926EEF6541D901E9D500@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <20150917123155.GC12808@leverpostej>
 <SN1PR0301MB1616F01085CC4549FFE3A1469D590@SN1PR0301MB1616.namprd03.prod.outlook.com>
Message-ID: <20150918074614.GA876@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 03:37:15AM +0100, Wang Dongsheng wrote:

[...]

> > > How about PSCI 1.0 support, could you share some information about it?
> > 
> > Lorenzo has implemented basic PSCI 1.0 support [1,2], and Sudeep has been
> > working on SYSTEM_SUSPEND [3], though I'm not immediately aware of the state of
> > the world there.
> > 
> > Do you have any specific questions?
> > 
> 
> There is no problem, I just want to use V1.0 to support our platform SYSTEM_SUSPEND,
> but 1.0 implementation is not in v4.3-rc1, so abandon this.

It will be in v4.4, so you can drop this patch then.

Thanks,
Lorenzo
