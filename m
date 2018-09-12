From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Sep 2018 10:39:05 +0800
Subject: i.MX DT memory nodes
In-Reply-To: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
References: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
Message-ID: <20180912023902.GA28239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 04:54:40PM -0500, Rob Herring wrote:
> It appears that many i.MX platforms have duplicate, incomplete memory
> nodes with both "memory" and "memory@<addr>" nodes. Are you all aware
> of this? Plan to fix it? I guess u-boot fixes things enough to work.

@Fabio, it seems that the most of them are caused by the empty 'memory'
node in <soc>.dtsi.  Can these be removed now?

Shawn
