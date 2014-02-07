From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 7 Feb 2014 10:45:04 +0100
Subject: [PATCH 19/21] ARM: MVEBU: Simplifiy headers and make local
In-Reply-To: <20140207103631.44789e1d@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-20-git-send-email-andrew@lunn.ch>
 <20140207093104.7197224d@skate> <20140207092047.GD17758@lunn.ch>
 <20140207103631.44789e1d@skate>
Message-ID: <20140207094504.GF17758@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:36:31AM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri, 7 Feb 2014 10:20:47 +0100, Andrew Lunn wrote:
> 
> > I wanted to keep 14/21 as a simple move of files, doing the minimal
> > needed to make it boot. The patches that follow then clean up. I found
> > that simpler to follow what was going on, since there is nothing
> > hidden in the move patch.
> > 
> > I can however squash these together if that is what people want to
> > see.
> 
> Ok. Then maybe the commit log should indicate this (that the commit is
> only a move and that followup commits clean things up).

Hi Thomas

The commit log for 14/21 currently is:

Move the kirkwood DT support into mach-mvebu, and make them part of                                              
ARCH_MULTI_V5. Minimal changes have been made in order to make it                                                
boot. More integration will take place in following patches. 

I could change "integration" to "integration and cleanup".

  Andrew
