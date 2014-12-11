From: joe@perches.com (Joe Perches)
Date: Wed, 10 Dec 2014 23:06:08 -0800
Subject: [PATCH v5 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <54893F26.5050304@rock-chips.com>
References: <1418208371-18851-1-git-send-email-lyz@rock-chips.com>
 <1418208371-18851-2-git-send-email-lyz@rock-chips.com>
 <5489338C.1030109@ti.com> <1418278322.18092.30.camel@perches.com>
 <54893963.7060304@ti.com> <1418279847.18092.32.camel@perches.com>
 <54893F26.5050304@rock-chips.com>
Message-ID: <1418281568.18092.34.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-12-11 at 14:52 +0800, Yunzhi Li wrote:
> On 2014/12/11 14:37, Joe Perches wrote:
> > On Thu, 2014-12-11 at 11:57 +0530, Kishon Vijay Abraham I wrote:
[]
> >> So If I have to write something on bit 0, I have to set bit 16.
> >> If I have to write something on bit 1, I have to set bit 17.
> >> If I have to write something on bit 2, I have to set bit 18.
> >> and so on.
> > To me it'd look better to use another << rather than a plus
> Like (BIT(13) << 16)? It looks strange, or could I just use ((1 << 13) 
> << 16) to describe this bit ?

Up to you.  To me, the BIT(x+y) seems odd.
