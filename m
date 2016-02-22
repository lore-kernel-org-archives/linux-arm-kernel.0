From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Feb 2016 13:41:05 +0000
Subject: [PATCH v4 4/5] arm64/perf: Enable PMCR long cycle counter bit
In-Reply-To: <20160222124514.GB766@hardcore>
References: <cover.1455810755.git.jglauber@cavium.com>
 <467597048eda3004bd69f1fbe3981aab111e00dd.1455810755.git.jglauber@cavium.com>
 <20160218173428.GE16883@arm.com> <20160222124514.GB766@hardcore>
Message-ID: <20160222134105.GD31168@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 01:45:14PM +0100, Jan Glauber wrote:
> On Thu, Feb 18, 2016 at 05:34:28PM +0000, Will Deacon wrote:
> > On Thu, Feb 18, 2016 at 05:50:13PM +0100, Jan Glauber wrote:
> > > With the long cycle counter bit (LC) disabled the cycle counter is not
> > > working on ThunderX SOC (ThunderX only implements Aarch64).
> > > Also, according to documentation LC == 0 is deprecated.
> > > 
> > > To keep the code simple the patch does not introduce 64 bit wide counter
> > > functions. Instead writing the cycle counter always sets the upper
> > > 32 bits so overflow interrupts are generated as before.
> > > 
> > > Original patch from Andrew Pinksi <Andrew.Pinksi@caviumnetworks.com>
> > 
> > What does this mean? Do we need Andrew's S-o-B, or is this a fresh patch?
> 
> Please let me know if I should repost or not, FWIW I got Andrew's S-o-B on the
> patch.

I think it's fine. This should all be in -next as of last Friday anyhow.

Will
