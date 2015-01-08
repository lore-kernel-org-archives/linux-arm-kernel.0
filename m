From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jan 2015 10:38:25 +0100
Subject: [PATCH v2 01/11] clk: sunxi: Add mod0 and mmc module clock
 support for A80
In-Reply-To: <CAGb2v66iEhdCxuLPRPLxJENUtB04GtbHDHu+7tuBHFqNL2foeA@mail.gmail.com>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
 <1418886058-8145-2-git-send-email-wens@csie.org>
 <20141219180235.GO4820@lukather>
 <CAGb2v66iEhdCxuLPRPLxJENUtB04GtbHDHu+7tuBHFqNL2foeA@mail.gmail.com>
Message-ID: <20150108093825.GP7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 20, 2014 at 08:43:27PM +0800, Chen-Yu Tsai wrote:
> > That looks a lot like the A10 MMC clock. What's changing? only the
> > data to feed to the factors setup code?
> 
> That's correct. Only the mux width in the data fed to the setup code
> and the lock differ.
> 
> The hardware can work with the a10 mod0 code, but it won't recover from
> cases where someone writes to the upper bits of the mux, since it doesn't
> know about them.

I'd very much prefer if we could factorise that code then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/80c7f14b/attachment.sig>
