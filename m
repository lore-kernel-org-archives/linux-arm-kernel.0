From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Oct 2013 09:37:35 +0100
Subject: [PATCH 1/2] ARM: kirkwood: add support for OpenBlocks A7 platform
In-Reply-To: <20131030195724.GI26784@titan.lakedaemon.net>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1383152110-19577-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131030195724.GI26784@titan.lakedaemon.net>
Message-ID: <20131031093735.68aa7df1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 30 Oct 2013 15:57:25 -0400, Jason Cooper wrote:

> > +			partition at 0 {
> > +				label = "uboot";
> > +				reg = <0x0 0x1c0000>;
> > +			};
> > +
> > +			partition at 90000 {
> > +				label = "env";
> > +				reg = <0x1c0000 0x2c0000>;
> > +			};
> 
> Hmm, something doesn't look right here.  Cut-n-paste problem?  Did you
> run 'make dtbs' against this?  I get address size errors when I do.

Strange. 'make dtbs' was working here. What was wrong exactly? Just
that the unit address (@90000) didn't match the starting address
0x1c0000 ?

> let me know if it's ok with you and I'll push it tomorrow.

This all looks good to me!

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
