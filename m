From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 13:21:46 +0000
Subject: Inconsistent kallsyms data on ARM.
In-Reply-To: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
References: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
Message-ID: <201203141321.47010.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Paul Gortmaker wrote:
> This bug(?)  has been seen to float from one ARM build to another since
> I started tracking the day-to-day changes in Stephen's linux-next builds.
> 
> I see it was discussed earlier:
> 
>    https://lkml.org/lkml/2011/8/2/233
>    https://lkml.org/lkml/2011/10/8/70
> 
> but no concrete cause was nailed down.  Can the linux-next build results
> help shed some light on this in any way?  Since it seems sporadic, is
> there value in embedding a diagnostic of some sort in the infrastructure
> so that when the error is detected, that it prints out more detailed info?
> 
> I can provide links to failed linux-next builds, but at the moment, all they
> really seem to have is the same repeated error message, like this one:
> 
>    http://kisskb.ellerman.id.au/kisskb/buildresult/5869367/
> 
> and I don't see that helping folks all that much....
> 

I'm sure I can reproduce it if necessary, but I need to know what to
look for to find out what the problem is.

	Arnd
