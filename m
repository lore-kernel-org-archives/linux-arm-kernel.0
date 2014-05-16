From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 13:08:45 +0900
Subject: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
In-Reply-To: <20140513081019.GA10412@verge.net.au>
References: <20140511231050.19908.86623.sendpatchset@w520>
 <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
 <20140513081019.GA10412@verge.net.au>
Message-ID: <20140516040844.GA2503@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 05:10:20PM +0900, Simon Horman wrote:
> On Mon, May 12, 2014 at 09:42:15AM +0200, Geert Uytterhoeven wrote:
> > On Mon, May 12, 2014 at 1:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > > From: Magnus Damm <damm+renesas@opensource.se>
> > >
> > > Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
> > > and CPUIdle in case of C-code less board support for r8a7740.
> > >
> > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Thanks, I will queue this up.

Hi Magnus, Hi Geert,

As I am currently doing some work for the r8a7779
I am wondering if a change like this one is appropriate for that SoC.
If so I'll cook one up.
