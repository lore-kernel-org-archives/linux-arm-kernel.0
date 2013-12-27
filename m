From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 Dec 2013 11:01:26 +0900
Subject: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <CAMuHMdXP4DAF1_DPtNfwCyP8WHFU03=zgM7i8FW9n6tcJpAHHQ@mail.gmail.com>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-3-git-send-email-wsa@the-dreams.de>
 <20131224024855.GC22401@verge.net.au>
 <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
 <20131226212539.GA2561@katana>
 <CAMuHMdXF6WmS_j4pC1U5jL3SK-ck7N=EA+-45duXdRZP1cOJkw@mail.gmail.com>
 <CAMuHMdXP4DAF1_DPtNfwCyP8WHFU03=zgM7i8FW9n6tcJpAHHQ@mail.gmail.com>
Message-ID: <20131227020126.GA9184@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 10:51:34PM +0100, Geert Uytterhoeven wrote:
> On Thu, Dec 26, 2013 at 10:34 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >>> Note that after dropping these lines:
> >>>
> >>>        CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
> >>>        CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
> >>>        CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
> >>>        CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
> >>>
> >>> i2c stopped working.
> >>
> >> ??? Why do you want to drop these lines?
> >
> > Your v2 dropped them, presumably in response to Sergei's ICKy comments.
> > And that's what Simon committed...
> 
> Upon checking again, your v2 did contain them, but gmail tried to smart
> me out by not showing those few lines.
> So it must have been Simon who dropped them, or lost them during rebase?

Yes, it seems so. Sorry about that!

Wolfram, could you post the these missing clocks as an incremental patch?
