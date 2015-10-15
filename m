From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 09:04:21 +0100
Subject: [PATCH v11 8/8] MAINTAINERS: Add entry Renesas arm64 architecture
In-Reply-To: <561F4B72.2050305@rvc.renesas.com>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-9-git-send-email-horms+renesas@verge.net.au>
 <561F4B72.2050305@rvc.renesas.com>
Message-ID: <20151015080421.GV32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 01:45:06PM +0700, Khiem Nguyen wrote:
> Hi Simon,
> 
> Thanks for your patch.
> 
> On 10/15/2015 1:24 PM, Simon Horman wrote:
> >Initial Renesas arm64 architecture support will be for the R-Car H3,
> >r8a7795, SoC and its Salvator-X board.
> >
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> >---
> >
> >Changes since v10:
> >- New Patch
> >---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 7ba7ab749c85..0067b7156622 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -1392,6 +1392,16 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
> >  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >
> >+ARM/RENESAS ARM64 ARCHITECTURE
> 
> I think you should add this near its younger brother, i.e ARM/RENESAS ARM
> ARCHITECTURE.

The file being modified has this in it:

  Note: For the hard of thinking, this list is meant to remain in alphabetical
  order. If you could add yourselves to it in alphabetical order that would be
  so much easier [Ed]

It's not freely orderable.

There is no "ARM/RENESAS ARM ARCHITECTURE" in the file.  There is
"ARM/SHMOBILE ARM ARCHITECTURE" though.


-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
