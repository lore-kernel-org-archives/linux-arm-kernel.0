From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 16 Nov 2016 16:55:37 -0700
Subject: [PATCH fpga 1/9] fpga zynq: Add missing \n to messages
In-Reply-To: <alpine.DEB.2.20.1611161621260.20443@atull-VirtualBox2>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <0aebdb59-86d7-2569-c49d-de5d45b5cac0@suse.com>
 <20161115180813.GB1852@obsidianresearch.com>
 <20161116183926.GA14341@live.com>
 <20161116201720.GC19593@obsidianresearch.com>
 <alpine.DEB.2.20.1611161621260.20443@atull-VirtualBox2>
Message-ID: <20161116235537.GA31885@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 04:28:27PM -0600, atull wrote:
> I agree that this needs a long description and I'm not sure
> why you're pushing back on that.

*shurg* it is just an unusual thing to ask for, but it is OK for a
subsystem to have a particular style like this. Other subsystems
do not.

I will add "This makes the driver prints display properly."

> You will need to rebase this series on linux-next.  I won't
> have much time this week to look at this, sorry.  Not sure
> what the hurry is.  I see the value of this, but things are
> busy right now.  I'll be getting up to speed on how the
> kernel does sg and this is kind of a fundamental change to
> the API so I appreciate your patience.

The merge window is opening soon so it would be nice to land some of
this in 4.10.

Since I have to rebase and restructure a chunk of it, I'd like to get
the bulk of the broad feedback collected before doing that..

Jason
