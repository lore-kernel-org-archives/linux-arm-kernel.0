From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 28 Dec 2016 09:21:38 +0800
Subject: [PATCH] usb: mtu3: fix U3 port link issue
In-Reply-To: <87lgv11usf.fsf@linux.intel.com>
References: <1481095393-23198-1-git-send-email-chunfeng.yun@mediatek.com>
 <87lgv11usf.fsf@linux.intel.com>
Message-ID: <1482888098.11166.0.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2016-12-27 at 13:22 +0200, Felipe Balbi wrote:
> Hi,
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> > the issue is introduced when @is_u3_ip is used in mtu3_device_enabe()
> > before initialized in mtu3_mem_alloc(), so get global IP information
> > at first before used by following functins.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> patch doesn't apply to my testing/fixes. Please rebase
It's already accepted into kernel4.10-rc1
> 
