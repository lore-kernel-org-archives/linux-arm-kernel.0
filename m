From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 30 Jan 2013 17:39:47 -0700
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130131002916.GW7717@titan.lakedaemon.net>
References: <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130129203221.GG7717@titan.lakedaemon.net>
 <51083580.1010900@gmail.com>
 <20130130224300.GU7717@titan.lakedaemon.net>
 <20130130230518.GA7395@obsidianresearch.com>
 <20130131002916.GW7717@titan.lakedaemon.net>
Message-ID: <20130131003947.GA23787@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 07:29:16PM -0500, Jason Cooper wrote:

> > Yes, you asked for the doc update and I haven't had a moment to get a
> > tree setup for that..
> 
> Ahh, that's right.  Sorry, wasn't trying to put pressure on you.  Just
> trying to make a reminder to myself of what to look for when I get to
> around to it.  (I have a separate IMAP folder for such things ;-) )

No worries, right now I'm in a spot where the lastest ARM stuff has
diverged so much that it is a major job to get my custom board working
against the latest tree, so I'm kinda stuck waiting on some spare
time/things to settle out...
 
> > Here are some words though:
> > 
> >      - local-mac-address : Optional, the MAC address to assign to the
> >        device. If not specified then the MAC address in the HW
> >        registers is used, but the driver can not be made modular.
> 
> I like it.  If I haven't seen anything when I get to this, I'll add this
> to your patch.  Please Ack if it's ok.  I prefer not to change peoples
> patches without approval.

Please feel free to merge this text and the patch into Ian's DT patch,
or rebase ontop of the latest version as you like:

Signed-off-by: Jason Gunthorpe

Thanks for sorting this ethernet stuff!

Jason
