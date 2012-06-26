From: mturquette@ti.com (Mike Turquette)
Date: Mon, 25 Jun 2012 18:55:51 -0700
Subject: linux-next: adding the common clk tree
Message-ID: <20120626015551.GW4402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Would you please add the clk-next branch of the common clock tree to
linux-next?

git://git.linaro.org/people/mturquette/linux.git clk-next

Thanks much!

For all of those Cc'd, I just wanted to say that I'm changing the way I
manage clk-next.  The clk-next branch now WILL be rebased, and it's only
purpose is to make it easy to test things in linux-next.  You can base
work on it, but be prepare for breakage and shifting commit ids.

If you don't want breakage and shifting commit ids then you might want
to use my clk-fixes branch (stable) and my clk-3.x branch (stable).  As
patches go through the linux-next cycle and appear stable I'll migrate
them over to clk-3.x which won't ever be rebased.  This is the branch
I'll send to Linus.  clk-next is simply comprised of merging clk-fixes,
clk-3.x and whatever unstable patches I have laying around.

Regards,
Mike
