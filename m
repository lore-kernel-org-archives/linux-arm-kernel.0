From: atull@opensource.altera.com (atull)
Date: Wed, 16 Nov 2016 16:28:27 -0600
Subject: [PATCH fpga 1/9] fpga zynq: Add missing \n to messages
In-Reply-To: <20161116201720.GC19593@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <0aebdb59-86d7-2569-c49d-de5d45b5cac0@suse.com>
 <20161115180813.GB1852@obsidianresearch.com>
 <20161116183926.GA14341@live.com>
 <20161116201720.GC19593@obsidianresearch.com>
Message-ID: <alpine.DEB.2.20.1611161621260.20443@atull-VirtualBox2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2016, Jason Gunthorpe wrote:

> On Wed, Nov 16, 2016 at 10:39:26AM -0800, Moritz Fischer wrote:
> > > As you say, it is crystal clear already, and this is an acceptable commit
> > > message.. Please suggest a text if you want to see something
> > > different.
> > > 
> > 
> > It still needs a long message. Just do it.
> 
> Can I put your reviewed-by on this when I resend the series?
> 
> Will you have time to review the other patches this week?
> 
> Jason
> 

Hi Jason,

I agree that this needs a long description and I'm not sure
why you're pushing back on that.

You will need to rebase this series on linux-next.  I won't
have much time this week to look at this, sorry.  Not sure
what the hurry is.  I see the value of this, but things are
busy right now.  I'll be getting up to speed on how the
kernel does sg and this is kind of a fundamental change to
the API so I appreciate your patience.

Alan
