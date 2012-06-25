From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jun 2012 10:18:18 +0100
Subject: [RFC PATCH 0/8] Fix restart_block syscall restarting for 3.5
In-Reply-To: <20120622193626.GG14083@ZenIV.linux.org.uk>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
 <20120622193626.GG14083@ZenIV.linux.org.uk>
Message-ID: <20120625091818.GB22128@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Fri, Jun 22, 2012 at 08:36:26PM +0100, Al Viro wrote:
> On Fri, Jun 22, 2012 at 04:06:58PM +0100, Will Deacon wrote:
> > I reckon the first two reverts should go in for 3.5 unless anybody has
> > a better solution. The rest of the code is an RFC since, as Russell has
> > said before, the code is `rather yucky'.
> 
> See commit 76c3f4da3ee47b68304dbe0f64e86562e7945bf3 and a couiple before it in
> signal.git:

Thanks, I'll take a look (it may keep me occupied for some time...). Are
these destined for 3.5 or shall we press ahead with the two reverts for now
and fix this properly in the merge window?

Cheers,

Will
