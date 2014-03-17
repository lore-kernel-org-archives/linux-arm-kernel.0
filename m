From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Mar 2014 23:29:07 -0700
Subject: [GIT PULL] Renesas intc Updates for v3.15
In-Reply-To: <cover.1392962498.git.horms+renesas@verge.net.au>
References: <cover.1392962498.git.horms+renesas@verge.net.au>
Message-ID: <20140317062907.GA21917@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 03:11:58PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider this Renesas ARM based SoC intc updates for v3.15.
> 
> Previously merging code for this driver was handled Paul Mundt
> as part of his maintenance of SUPERH. However, SUPERH is in
> the process of being orphaned. And as this driver is also listed
> as being maintained by Magnus and myself as part of ARM/SHMOBILE ARM
> I have picked up this patch.
> 
> If you would prefer not to handle this that is quite fine by me but in that
> case I would appreciate advice on where I should send pull-requests.

Do you anticipate any new development besides some minor one-off fixes and
touching code that's related to shmobile/sh reworks?

If it's a low-volume thing that is likely to mostly have overlap with
arm-soc/shmobile stuff then we might just as well take most of it. Otherwise,
I think most architecture maintainers send things directly to Linus.

Either way, I'll merge this for now.


-Olof
