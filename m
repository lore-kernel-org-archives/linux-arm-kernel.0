From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 20:42:38 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.4
In-Reply-To: <CAMuHMdUkzv9BE4PDjm3Qkk87f2Lq6Bn-CNb+r3dtSWhbkN39Wg@mail.gmail.com>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
 <5419864.uERWTbJ9BK@wuerfel>
 <CAMuHMdUkzv9BE4PDjm3Qkk87f2Lq6Bn-CNb+r3dtSWhbkN39Wg@mail.gmail.com>
Message-ID: <13543534.MsGb8OrGPX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 17:47:37 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Tue, Oct 6, 2015 at 3:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 17 September 2015 17:59:33 Simon Horman wrote:
> >> Please consider these Renesas ARM based SoC cleanup for v4.4.
> >>
> >>  24 files changed, 4 insertions(+), 2687 deletions(-)
> >>
> >> Is a pleasing diffstat if I do say so myself.
> >>
> >> Of particular note the last legacy board code for Renesas ARM based SoCs,
> >> that of the bockw board, is removed in this pull request.
> >
> > After a long delay in response, I've merged it now into next/cleanup.
> >
> > So the transition is complete and you beat me with the multiplatform
> > conversion that I have pending for the other ARMv7 platforms, nice work!
> 
> Thanks for pulling!
> 
> Now I can start out sending my platform data removal series...

Ok, cool.

I don't think that there is generally a need to wait before sending
stuff out that depends on pull requests to get merged.

> > I've used the opportunity to look for any remaining code that you may
> > have missed, by tracking symbols that are defined globally but never used
> > in mach-shmobile, and didn't find much (which is good).
> >
> > Could you have a look at the patch below and integrate the parts that
> > make sense to you?
> 
> I think most of this has already been fixed in Simon's next branch in the mean
> time.

Ok, thanks for taking a look.

	Arnd
