From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 18:02:26 +0000
Subject: [PATCH] ARM: DT/kernel: fix arch_match_cpu_phys_id to avoid
 erroneous match
In-Reply-To: <52CD2F5A.5000001@arm.com>
References: <1382358632-32762-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20140107165815.GF4180@e106331-lin.cambridge.arm.com>
 <52CD2F5A.5000001@arm.com>
Message-ID: <20140108180225.GL27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 10:58:34AM +0000, Sudeep Holla wrote:
> Hi Russell,
> 
> On 07/01/14 16:58, Mark Rutland wrote:
> > Hi,
> > 
> > I was just looking in devtree.c and I noticed this seems to have fallen
> > by the wayside. Given that this fixes a possible bug and there have been
> > no negative comments, I think it's good for mainline.
> > 
> > Could you place this in the patch system, assuming Russell has no
> > comments?
> > 
> 
> Can I put this in patch tracker if you have no objections ?

Yes please.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
