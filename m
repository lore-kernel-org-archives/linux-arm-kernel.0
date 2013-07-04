From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Jul 2013 21:49:32 +0800
Subject: Mainline crashes in wm8962_probe() on i.MX6
In-Reply-To: <F7C43F8B2814514CA05F3436BC68046EF3A272@039-SN2MPN1-011.039d.mgd.msft.net>
References: <F7C43F8B2814514CA05F3436BC68046EF3A272@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <20130704134930.GC11046@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 10:44:11AM +0000, Stehle Vincent-B46079 wrote:
> Hi,
> 
> Mainline of today* will not boot anymore on i.MX6 with ARM config imx_v6_v7_defconfig. It crashes in wm8962_probe() (see log below).
> 
> Bisecting points at merge commit 1286da8bc009cb2aee7f285e94623fc974c0c983, but its two "parents" commits do not crash.

Yeah, I just ran into it with linux-next and reported it there [1].  I
will send a formal patch for it soon.

Shawn

[1] http://thread.gmane.org/gmane.linux.alsa.devel/109844
