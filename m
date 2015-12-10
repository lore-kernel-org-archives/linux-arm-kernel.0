From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Dec 2015 16:04:48 +0900
Subject: [PATCH] ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
In-Reply-To: <CAMuHMdWy3BWSe7ASwN4JejoJR8cDT06gSA5d+bPSRB7COR3Mzg@mail.gmail.com>
References: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
 <20151201064434.GI16260@verge.net.au>
 <CAMuHMdWy3BWSe7ASwN4JejoJR8cDT06gSA5d+bPSRB7COR3Mzg@mail.gmail.com>
Message-ID: <20151210070447.GC17682@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 10:28:22AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Dec 1, 2015 at 7:44 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Nov 30, 2015 at 02:35:34PM +0100, Geert Uytterhoeven wrote:
> >> Enable timestamps for kernel log output to improve debugging.
> >> You can always use "dmesg -t" to strip the timestamps.
> >>
> >> Don't specify CONFIG_LOG_BUF_SHIFT=16 while we're at it.  There's a
> >> reason the default in Kconfig is higher ;-)
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks, I have queued this up.
> 
> Still not present in renesas-devel?

Sorry about that, it should appear there soon.
