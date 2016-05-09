From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 15:10:40 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT PM Domain Updates for v4.7
In-Reply-To: <20160506002125.GE24999@verge.net.au>
References: <cover.1461730364.git.horms+renesas@verge.net.au>
 <20160506002125.GE24999@verge.net.au>
Message-ID: <41128314.QPDQXbTtHX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 May 2016 09:21:25 Simon Horman wrote:
> Hi,
> 
> On Wed, Apr 27, 2016 at 02:20:10PM +1000, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM64 based SoC DT PM Domain updates for v4.7.
> > 
> > This pull requests is based on a merge of:
> > 
> > * "[GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates for
> >   v4.7", tagged as renesas-rcar-sysc2-for-v4.7, which you have already
> >   pulled
> > * "[GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v4.7",
> >   tagged as renesas-arm64-dt2-for-v4.7, which I have sent a pull request
> >   for.
> > 
> > The reason for the somewhat tedious base on
> > renesas-rcar-sysc2-for-v4.7, which provides driver changes,
> > is a hard run-time dependency.
> > 
> > I also have a similar set of changes for ARM (32-bit) which I will send
> > separately.
> 
> I am wondering if this pull-request might have slipped through the cracks.
> 
> FWIW, all other pull requests I have submitted for v4.7 have been pulled
> (thanks!) including a similar pull-request for ARM (32-bit) which is
> present in the next/late branch of the arm-soc tree.
> 
> I do not plan to send any more non-fix pull requests for v4.7.
> And at this stage I am not aware of any fixes for v4.7.
> 

Indeed it did, thanks for the reminder! I've put it on my stack now
and should start doing merges later today when I'm through my mail.

	Arnd
