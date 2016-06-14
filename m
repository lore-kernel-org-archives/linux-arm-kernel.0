From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Tue, 14 Jun 2016 10:19:40 +0800
Subject: [PATCH v3,2/5] dt-bindings: mt8173-mtu3: add devicetree bindings
In-Reply-To: <878tyd761u.fsf@linux.intel.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
 <1465543962-11678-3-git-send-email-chunfeng.yun@mediatek.com>
 <878tyd761u.fsf@linux.intel.com>
Message-ID: <1465870780.19154.0.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-06-10 at 12:21 +0300, Felipe Balbi wrote:
> Hi,
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> > + - enable-manual-drd : supports manual dual-role switch via sysfs; only used
> > +	when receptacle is TYPE-A and also wants to support dual-role mode.
> 
> sorry, but this manual-drd can't be accepted. You should rely on a DT
> property for this and you shouldn't expose it to sysfs. Use DebugFS for
> that.
I will make use of debugfs instead
Thanks a lot
> 
> 
