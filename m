From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 20:47:29 +0100
Subject: [PATCH v2 0/5] ARM: KVM: Enable the ioeventfd capability of KVM
 on ARM
In-Reply-To: <54B7DD6B.1060002@linaro.org>
References: <20141207093641.17563.84226.stgit@i3820>
 <54B440D0.6090707@linaro.org>
 <CADDJ2=M2UjsV0U9cFiRoKghWSckWje+h6M-XQ-0dqPrH3BXp1A@mail.gmail.com>
 <54B7DD6B.1060002@linaro.org>
Message-ID: <20150115194729.GZ26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 04:31:55PM +0100, Eric Auger wrote:
> On 01/15/2015 04:25 PM, Nikolay Nikolaev wrote:
> > 
> > 
> > On Mon, Jan 12, 2015 at 11:46 PM, Eric Auger <eric.auger@linaro.org
> > <mailto:eric.auger@linaro.org>> wrote:
> > 
> >     Hi Nikolay,
> > 
> >     looks good to me overall. A rebase on Christoffer's vgic init series
> > 
> > is there a tree where these patches are published?
> Hi Nikolay,
> 
> Yes Andre's kvm-gicv3/v7 branch on https://github.com/apritzel/linux.git
> seems to contain all those.
> 
Probably be good to wait until these are in kvmarm/next along with the
dirty page logging stuff and rebase on that.

-Christoffer
