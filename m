From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Fri, 13 May 2016 10:00:20 +0800
Subject: [PATCH 3/6] dt-bindings: mtu3: add devicetree bindings
In-Reply-To: <CAOGqxeUYEGKq5yhHbgcjPZtY06ZfDp2iCLZDqS3uyfCW523B4w@mail.gmail.com>
References: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
 <1462868614-20602-4-git-send-email-chunfeng.yun@mediatek.com>
 <20160511145409.GA23042@rob-hp-laptop>
 <1463037844.11651.118.camel@mhfsdcap03>
 <CAOGqxeUYEGKq5yhHbgcjPZtY06ZfDp2iCLZDqS3uyfCW523B4w@mail.gmail.com>
Message-ID: <1463104820.11651.125.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2016-05-12 at 19:02 -0400, Alan Cooper wrote:
> On Thu, May 12, 2016 at 3:24 AM, chunfeng yun <chunfeng.yun@mediatek.com> wrote:
> >> > + - mediatek,enable-manual-drd : supports manual dual-role switch by sysfs
> >> > +   interface; only used when receptacle is TYPE-A and also wants to support
> >> > +   dual-role mode.
> >>
> >> sysfs is a Linux detail that doesn't apply to the binding. Does the
> >> property mean "the IP block supports or doesn't support switching"  or
> >> "I want to enable switching feature". Only the former belongs in DT.
> >>
> > It is the former case, and has little relation with sysfs interface.
> > I will modify it later, sorry for my unclear description.
> 
> Could the property name be just "enable-manual-drd" instead of
> "mediatek,enable-manual-drd"? I expect to have to add this
> functionality to our USB driver in the near future.

Do you mean provide some APIs to in common USB driver?
