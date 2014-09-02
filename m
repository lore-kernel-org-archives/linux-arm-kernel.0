From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Sep 2014 10:16:08 +0900
Subject: [PATCH] ARM: dts: Sort SHMOBILE dtbs alphabetically
In-Reply-To: <20140829003204.GA22661@verge.net.au>
References: <1409227243-25102-1-git-send-email-geert+renesas@glider.be>
 <20140829003204.GA22661@verge.net.au>
Message-ID: <20140902011608.GC12650@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 09:32:04AM +0900, Simon Horman wrote:
> On Thu, Aug 28, 2014 at 02:00:43PM +0200, Geert Uytterhoeven wrote:
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This depends on Magnus' series "[PATCH 00/05] ARM: shmobile: r8a7740 and
> > Armadillo cleanup".
> 
> As per my response to that series:
> 
>    Thanks. I have tentatively queued this up.
> 
>    I got some push back from Olof [CCed] about putting cleanups on top of
>    development when sending pull-requests for v3.17. This series falls
>    into the same category: cleaning up board and related files on top
>    of changes to initialise devices using DT.
> 
>    Olof, ideally I'd like this to go into v3.18.
>    Let me know if you have preference to delay it.

Hi Geert,

I have reconsidered this and I think that it would be best to
defer this cleanup until v3.19. The reason for this is that
I believe that there are plans to both add and DTS files during
v3.18, which would conflict with this release cycle.

Please repost this patch once v3.17-rc6 has been released.
