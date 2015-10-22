From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Oct 2015 09:50:51 +0900
Subject: [PATCH 14/19] ARM: dts: shmobile/r8a7xxx: replace
 gpio-key,wakeup with wakeup-source property
In-Reply-To: <56276787.6090900@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-15-git-send-email-sudeep.holla@arm.com>
 <CAMuHMdXpY7gSOPAGxh9Z_LurpL392y7Vx0pBe-FqfauXjVnMFQ@mail.gmail.com>
 <56276787.6090900@arm.com>
Message-ID: <20151022005051.GD8879@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 11:23:03AM +0100, Sudeep Holla wrote:
> 
> 
> On 21/10/15 11:18, Geert Uytterhoeven wrote:
> >On Wed, Oct 21, 2015 at 12:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> >>check for/support the legacy "gpio-key,wakeup" boolean property to
> >>enable gpio buttons as wakeup source, "wakeup-source" is the new
> >>standard binding.
> >>
> >>This patch replaces the legacy "gpio-key,wakeup" with the unified
> >>"wakeup-source" property in order to avoid any futher copy-paste
> >>duplication.
> >
> >Thanks!
> >
> >I made the same changes to my local tree a few weeks ago, but never found
> >time to send them out...
> >
> 
> Ah OK, even I had these changes for long. I waited until I fixed all the
> binding documents(which was boring ;))
>
> >>Cc: Simon Horman <horms@verge.net.au>
> >>Cc: Magnus Damm <magnus.damm@gmail.com>
> >>Cc: linux-sh at vger.kernel.org
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> >Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Can I clarify that you would like me to pick up this patch?
If so I'm happy to do so.

Else:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
