From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 11:28:50 +0200
Subject: [PATCH] [RESEND] ARM: remove last use of CONFIG_CPU_ARM710
In-Reply-To: <1400059550.31197.12.camel@x220>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <8309592.drxAj71PnZ@wuerfel> <1400059550.31197.12.camel@x220>
Message-ID: <4305975.PvMXZQ020k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 11:25:50 Paul Bolle wrote:
> On Wed, 2014-05-14 at 11:17 +0200, Arnd Bergmann wrote:
> > 'git grep -i arm710' tells me that there is also some arm710
> > specific code in  arch/arm/mm/proc-arm720.S that we may want to
> > remove along with this.
> > 
> > The DT binding should probably remain untouched though, I think it's
> > correct to document the string.
> 
> That seems to be cpu_arm710_name, __arm710_setup, and everything called
> by __arm710_setup. Cleaning that up (as a separate patch) appears to be
> trivial. If I do that it would be (sort of educated) guesswork. But I
> don't mind doing it. What do you prefer?

I think that would be great. For the first patch, please add 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Once the second patch is reviewed, please add them both to Russell's
patch tracker.

	Arnd
