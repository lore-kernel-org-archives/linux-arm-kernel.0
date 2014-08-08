From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Aug 2014 11:17:56 -0300
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <1407507023.19455.3.camel@sharkbay.at>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
Message-ID: <CAOMZO5BVPfXCzihwPQZYrNOmuBEWALW5rQq=M2qVmCLjmFFZig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Fri, Aug 8, 2014 at 11:10 AM, Thomas Scheiblauer <tom@sharkbay.at> wrote:

> These lines in arch/arm/boot/dts/imx6qdl-wandboard.dtsi already seem to
> be a workaround for some hardware errata:
> ERR006687 ?ENET: Only the ENET wake-up interrupt request can wake the
> system from Wait mode?
>
> See the original mail containing the patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221204.html

This commit is also in 3.15 kernel. Do you have this instability issue in 3.15?

It would be helpful if you could revert commit 9fc77821b17155c6e0 with
3.16 and try again, just to make sure that the workaround is not
introducing issues.
