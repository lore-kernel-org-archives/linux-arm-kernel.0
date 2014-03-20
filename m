From: rui.zhang@intel.com (Zhang Rui)
Date: Thu, 20 Mar 2014 13:57:45 +0800
Subject: [PATCH v2 3/5] thermal: dove: prepare new Dove DT Kconfig variable
In-Reply-To: <20140304040318.GG1872@titan.lakedaemon.net>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140304040318.GG1872@titan.lakedaemon.net>
Message-ID: <1395295065.3571.10.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-03 at 23:03 -0500, Jason Cooper wrote:
> On Sat, Mar 01, 2014 at 09:33:19AM +0100, Sebastian Hesselbarth wrote:
> > DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> > mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> > DT-only MACH_DOVE Kconfig.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Rui, Eduardo,
> > 
> > Mark Brown requested to take the corresponding ASoC patch through
> > his tree. Therefore, I have split the former patch into individual subsystem
> > patches.              
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: linux-pm at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > ---
> >  drivers/thermal/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

applied.

thanks,
rui
> 
> thx,
> 
> Jason.
