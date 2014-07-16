From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jul 2014 09:16:58 -0400
Subject: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
In-Reply-To: <20140716145905.33105756@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140713222223.GH13108@titan.lakedaemon.net>
 <20140716124522.GV13108@titan.lakedaemon.net>
 <20140716145905.33105756@free-electrons.com>
Message-ID: <20140716131658.GB13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 02:59:05PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 16 Jul 2014 08:45:22 -0400, Jason Cooper wrote:
> 
> > Ok, so I applied patch #10 to mvebu/dt, and #17 to mvebu/defconfig.  I
> > was then going to apply the rest into a tentative topic branch
> > (mvebu/soc-cpuidle), but it failed when based on v3.16-rc1, and it
> > failed when based on mvebu/soc.
> > 
> > Could you please outline the deps so I can get this into -next?  We're
> > really cutting the deadline close for v3.17, and I'd like to already
> > have some time in -next if/when cpuidle Ack's it going through the mvebu
> > tree.
> 
> As explained in the cover letter:
> 
>  * Series rebased on top of mvebu/fixes + mvebu/soc to take into
>    account the conflicts with the changes already merged on the PMSU
>    code.

Ok, I've tentatively applied this series to mvebu/soc-cpuidle with a dep
on mvebu/soc and mvebu/fixes.  It'll be in -next tonight.

thx,

Jason.
