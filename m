From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Oct 2015 09:20:11 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: fix "gpio-ranges" props
In-Reply-To: <CAMuHMdVEBAJVezoj=Nm_upRSM_YjMrD8MmpX6EsT-4=vZTg+pQ@mail.gmail.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <5904216.pOYUtEytKc@wasted.cogentembedded.com>
 <CAMuHMdVEBAJVezoj=Nm_upRSM_YjMrD8MmpX6EsT-4=vZTg+pQ@mail.gmail.com>
Message-ID: <20151023002010.GC15844@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 01:06:02PM +0200, Geert Uytterhoeven wrote:
> On Thu, Oct 22, 2015 at 1:05 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On R8A7791, GPIO banks 1 and 7  are missing  pins 26 to 31.  Correct the
> > "gpio-ranges" properties of the GPIO1 node (GPIO7 is already correct).
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> LEDs and keys on r8a7791/koelsch (which are connected to a higher gpio)
> still work fine.
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
