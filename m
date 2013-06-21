From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jun 2013 09:40:19 +0100
Subject: [PATCH v2 0/2] ARM: Remove any correlation between IPC and
 BogoMips value
In-Reply-To: <alpine.LFD.2.03.1306201452330.18597@syhkavp.arg>
References: <1371746612-23950-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1306201452330.18597@syhkavp.arg>
Message-ID: <20130621084018.GB6983@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:54:21PM +0100, Nicolas Pitre wrote:
> On Thu, 20 Jun 2013, Will Deacon wrote:
> 
> > Hi all,
> > 
> > This is version two of the patches I originally posted here:
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/166728.html
> > 
> > Comments received there largely confirmed that it's not possible to choose
> > an `obviously bogus' value for BogoMIPs, so instead I've bitten the bullet
> > and removed the line altogether.
> > 
> > In the meantime, I've only had one complaint this month about BogoMIPs
> > being wrong, so perhaps the initial posting served some purpose without
> > even being merged!
> > 
> > Comments welcome,
> 
> Enthusiastic ACK for both patches.

Thanks Nicolas!

Will
