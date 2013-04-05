From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 5 Apr 2013 16:58:04 +1100
Subject: linux-next: manual merge of the arm-soc tree with the xilinx tree
In-Reply-To: <CAHTX3d++6JWTKWkGOfgJj10z1Xtx325YXNQ6eMJjM8HO4q1diw@mail.gmail.com>
References: <20130405153335.baf29606a97b1bee415f3546@canb.auug.org.au>
 <20130405153453.75b76d68fe9adc6e981e02fb@canb.auug.org.au>
 <CAHTX3d++6JWTKWkGOfgJj10z1Xtx325YXNQ6eMJjM8HO4q1diw@mail.gmail.com>
Message-ID: <20130405165804.c4def5754d316e5da691ceee@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Fri, 5 Apr 2013 07:52:34 +0200 Michal Simek <monstr@monstr.eu> wrote:
>
> 2013/4/5 Stephen Rothwell <sfr@canb.auug.org.au>
> >
> > BTW, that xilinx tree commit has no "Signed-off-by" for the committer ...
> 
> Interesting that you can't see Rob's Signed-off-by line.

Rob was the author, you were the committer ...

$ git cat-file -p c79e33b3e828c79cfedf858ef7d4df96df5fece7
tree 1e5e352eb501a2afa173989415a8b4896d4999a5
parent ab8a98cff21aedb787934e8d366c9879ad0e824c
author Rob Herring <rob.herring@calxeda.com> 1360207067 -0600
committer Michal Simek <michal.simek@xilinx.com> 1365060716 +0200

ARM: smp_twd: convert to use CLKSRC_OF init

Now that we have OF based init with CLKSRC_OF, convert smp_twd init
function to use it and covert all callers of
twd_local_timer_of_register.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap at vger.kernel.org
Cc: spear-devel at list.st.com
Reviewed-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/5632d0f7/attachment.sig>
