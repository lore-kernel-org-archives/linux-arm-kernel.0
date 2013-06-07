From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 09:45:48 +0200
Subject: [PATCH 0/8] Support Marvell bootloaders remapping registers at
 different locations
In-Reply-To: <20130606180201.GM23859@titan.lakedaemon.net>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130605210104.GQ3803@titan.lakedaemon.net>
 <20130606180201.GM23859@titan.lakedaemon.net>
Message-ID: <20130607094548.2695a4a7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 6 Jun 2013 14:02:01 -0400, Jason Cooper wrote:

> > I've tentatively pulled your series into mvebu/regmap with
> > appropriate dependencies.
> > 
> > I was going to put this in for-next, but I got a build error after
> > merging it.  Could you do me a favor and try merging this with
> > mvebu/seb_clk?  Just shoot me the merge resolution that builds
> > mvebu_defconfig correctly, and I'll incorporate it into the merge.
> > No need to rebase the series.
> > 
> > If you want to reproduce what I saw, just merge mvebu/regmap with
> > for-next (up shortly), and build mvebu_defconfig.
> 
> This has now been resolved, whole series, with v2 of the one patch is
> in mvebu/regmap.

Ah, yes, sorry, I didn't reply to your e-mail, but we sorted it
together on IRC right after you sent the mail.

Thanks for integrating the v2 of the patch!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
