From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 18:22:01 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515164438.22258885@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch> <4FB22727.6090406@codethink.co.uk>
 <20120515115511.75ece9c3@skate> <4FB269CB.4080804@gmail.com>
 <20120515164438.22258885@skate>
Message-ID: <20120515162201.GZ23254@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 04:44:38PM +0200, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 09:35:55 -0500,
> Rob Herring <robherring2@gmail.com> a ??crit :
> 
> > Directory location doesn't really have anything to do with what can be
> > in a single kernel binary. We will soon be building single images
> > across mach directories.
> 
> Agreed, but it's not the case right now, and we wanted to submit today
> a kernel that boots on both of those SoCs.
> 
> The 370 and XP both use the PJ4B core

Could mach-pj4b be an option?
      
      Andrew
