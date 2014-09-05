From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 5 Sep 2014 08:35:25 +0800
Subject: [PATCH 0/3] move gpt per clk parent for ipg_per to OSC
In-Reply-To: <CAOMZO5BOfsvrH3ijxKwyGemEW-B60n-+4wpDZ5xfC98efM469w@mail.gmail.com>
References: <1409729805-9741-1-git-send-email-b20788@freescale.com>
 <CAOMZO5BOfsvrH3ijxKwyGemEW-B60n-+4wpDZ5xfC98efM469w@mail.gmail.com>
Message-ID: <20140905003523.GD10809@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 07:50:35PM -0300, Fabio Estevam wrote:
> This patch series works fine if we use the new dtb and new kernel.
> 
> However, booting a kernel with these series applied and using an old
> dtb we get a system with broken timer.
> 
> 'sleep 1' takes something like 20 seconds in this case.

Oh, yes.  It breaks the compatibility with existing DTB.  Dropped the
patches for now.

Anson,

We may need to query the clock rate and then decide how to set up those
register bits?

Shawn
