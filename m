From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Apr 2012 16:52:38 -0300
Subject: question about i.mx21ads support
In-Reply-To: <CAEqTKjUyiA_fCfboifSXXj-h_B6rGQpAM9nGnen=0mKi-w=J9w@mail.gmail.com>
References: <CAEqTKjUyiA_fCfboifSXXj-h_B6rGQpAM9nGnen=0mKi-w=J9w@mail.gmail.com>
Message-ID: <CAOMZO5BWiQoRL3HJy7wgWUjA=FtnJJ9vqt5oau-0n6_SJT_AFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 2:30 PM, George McBay <gfm@funxed.com> wrote:
> I'm attempting to revive an old i.mx21ads board (Freescale dev board,
> M9328MX21ADS Rev E) with a newish Linux kernel but haven't had yet had
> luck getting a build after version 3.1.10 to boot successfully. ?Given
> the age of this platform, it seems entirely plausible that nobody is
> actually runtime testing against this board, though I suppose it may
> also come down to something specific in my board revision.

Please try 3.3 kernel instead.

You are probably missing this patch:
http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=commitdiff;h=1a96571db0a80dbbb935dee26589dd528da0ed06;hp=039d7ba4bcfb1e0040be6f7812a410e6744ce69e

I do not have access to a mx21ads, but Jaccon on Cc has submitted some
mx21ads related patches recently.

Regards,

Fabio Estevam
