From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2011 14:14:36 +0000
Subject: [GIT PULL] Identity mapping changes for 3.3
In-Reply-To: <20111206103843.GM14542@n2100.arm.linux.org.uk>
References: <20111202160833.GK5540@mudshark.cambridge.arm.com>
 <20111205232342.GG14542@n2100.arm.linux.org.uk>
 <20111206101438.GB25782@mudshark.cambridge.arm.com>
 <20111206103843.GM14542@n2100.arm.linux.org.uk>
Message-ID: <20111206141436.GK25782@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 10:38:43AM +0000, Russell King - ARM Linux wrote:
> > > As this is known to be broken on OMAP, could I have this based upon
> > > some other commit - maybe ba8bb18a03f which I've just committed into
> > > devel-stable (which is the second 'fix' patch for OMAP) please.
> > 
> > I'm struggling to pull from you [1] at the moment, but I'll rebase this once I
> > manage to get the updated devel-stable.
> 
> It looks like the machine is hitting the memory and disk io bandwidth
> limits.  Unfortunately, git seems to have high demands for both of those,
> weighing in at around 300-400MB per pack process, and seemingly wanting
> to read all the pack files too.

Ok, I've got it now and have pushed out the new branch (kexec/idmap) based
on the commit that you suggested above.

Cheers,

Will
