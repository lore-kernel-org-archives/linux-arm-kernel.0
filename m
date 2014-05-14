From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 14 May 2014 22:21:26 +1000
Subject: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock
 support
In-Reply-To: <CAMuHMdWK1WAePx3N_ybPkWcoTtP_6PdcEPNEyBv02A9zOZSWOg@mail.gmail.com>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
 <CAMuHMdWK1WAePx3N_ybPkWcoTtP_6PdcEPNEyBv02A9zOZSWOg@mail.gmail.com>
Message-ID: <20140514222126.5d10212f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, 14 May 2014 12:26:38 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, May 13, 2014 at 2:05 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Wolfram Sang (2014-04-29 03:03:32)
> >> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>
> >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Acked-by: Mike Turquette <mturquette@linaro.org>
> >
> > No need to take this through the clk tree. Feel free to send it with the
> > rest through arm-soc.
> 
> (merging in clk/clk-next)
> 
> Note that this will cause a conflict for you, as Mike applied commit
> 5483bf698f42a6f0467463b064084eb888298232 ("clk: shmobile: r8a7779:
> Add MSTP clock support"), which adds a line at the exact same spot.
> 
> Resolution: both lines should be kept.

Thanks.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/8a7768c7/attachment.sig>
