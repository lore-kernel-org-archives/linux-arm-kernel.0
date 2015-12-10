From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Dec 2015 13:48:15 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7793: Add missing serial devices
 to DT
In-Reply-To: <CAMuHMdUXaO6PynwOaEP9e88F10uJSoc7u848RgnDVRdqyYFnTg@mail.gmail.com>
References: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
 <1448589166-11612-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUXaO6PynwOaEP9e88F10uJSoc7u848RgnDVRdqyYFnTg@mail.gmail.com>
Message-ID: <20151210044815.GB6964@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 11:42:35AM +0100, Geert Uytterhoeven wrote:
> On Fri, Nov 27, 2015 at 2:52 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Instantiate all serial devices in r8a7793 device tree
> > and set them as disabled by default.
> >
> > Based on similar work for the r8a7791 by Laurent Pinchart.
> >
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
