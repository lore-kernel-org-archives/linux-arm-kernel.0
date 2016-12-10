From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Dec 2016 20:19:19 +0100
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <20161210181639.GA5660@afzalpc>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc>
Message-ID: <2683998.OKe6qmCH0L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, December 10, 2016 11:46:39 PM CET Afzal Mohammed wrote:
> Hi,
> 
> On Fri, Dec 02, 2016 at 03:05:18PM +0000, Vladimir Murzin wrote:
> 
> > there was little interest to run A-class with MMU disabled (or
> > 1:1 MMU mapping) as well.
> 
> With a few more changes, on a Cortex-A platform, Kernel reached
> maximum it can proceed w/o user space help, i.e. upto,
> 
> "Kernel panic - not syncing: No working init found."
> 
> Creating user space executables suitable for Cortex-A !MMU is the
> distance to reach prompt.
> 
> Seems no !MMU A-class suitable toolchains are available, the existing
> !MMU toolchains available are for either M or R class. Looks like
> FDPIC one's also are so (cc'ing Maxime & Mickeal in case they have
> some input here).
> 
> And compiling a suitable compiler failed.
> 
> Let know if any signposts to travel the remaining distance.
> 
> PS: Version used was v2 instead of this v3 series.

What's wrong with the R class toolchain?

	Arnd
