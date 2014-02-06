From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 6 Feb 2014 16:10:24 -0300
Subject: [PATCH v6 18/19] ARM: mvebu: Enable watchdog support in defconfig
In-Reply-To: <20140206175159.GI8533@titan.lakedaemon.net>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-19-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140206175159.GI8533@titan.lakedaemon.net>
Message-ID: <20140206191023.GA19328@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 12:51:59PM -0500, Jason Cooper wrote:
> On Thu, Feb 06, 2014 at 02:20:25PM -0300, Ezequiel Garcia wrote:
> > Now that we have proper support for Armada 370/XP watchdog
> > let's enable it in the defconfig.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/configs/mvebu_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> If this ends up being the last version for this series, I'll add a patch
> for multi_v7_defconfig.  Otherwise, please add for the next round.
> 

Oh, yes, I forgot about your request on this. Let's hope I don't forget
next time.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
