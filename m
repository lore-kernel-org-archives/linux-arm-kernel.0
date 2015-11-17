From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Tue, 17 Nov 2015 15:50:02 +0800
Subject: [PATCH] phy: phy-mt65xx-usb3: fix test fail of HS receiver
 sensitivity
In-Reply-To: <20151117061619.GB18947@kroah.com>
References: <1447740178-29588-1-git-send-email-chunfeng.yun@mediatek.com>
 <20151117061619.GB18947@kroah.com>
Message-ID: <1447746602.18917.8.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Mon, 2015-11-16 at 22:16 -0800, Greg KH wrote:
> On Tue, Nov 17, 2015 at 02:02:58PM +0800, Chunfeng Yun wrote:
> > when use the default value 8 of RG_USB20_SQTH, the HS receiver
> > sensitivity test of HQA will fail, set it as 2 to fix up the
> > issue.
> > 
> > Change-Id: Ia5bdbbfc8ebb170d3ef26007e665b7350b6d28ab
> 
> What is this field for?  Hint, it should never be there for a patch you
> submit upstream as it means nothing...
> 
I'm sorry for forgetting remove it. 
And I will remove change-id in next round after review

Thanks a lot

> greg k-h
