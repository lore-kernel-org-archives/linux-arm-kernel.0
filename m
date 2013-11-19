From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Nov 2013 16:53:47 +0100
Subject: [PATCH v4 0/4] Add support for the Allwinner A31 Reset Controllers
In-Reply-To: <1384871415.6790.30.camel@pizza.hi.pengutronix.de>
References: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
 <1384798284.4348.33.camel@pizza.hi.pengutronix.de>
 <20131119074929.GE5325@lukather>
 <1384871415.6790.30.camel@pizza.hi.pengutronix.de>
Message-ID: <20131119155347.GA1029@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, Nov 19, 2013 at 03:30:15PM +0100, Philipp Zabel wrote:
> > Do you want to merge this through your tree?
> 
> since 0d74578b7de73c4b7f25daaacff8d5091fa83bd4 "ARM: sunxi:
> remove .init_time hooks", patch 3/4 doesn't apply against soc/for-next
> anymore.
> I could take the first patch now, and you merge the other three through
> your tree afterwards?

Hmmm, patch 1, 2 and 3 can't be merged independently.

I guess the easiest will be for me to merge it with your Acked-by.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/1c6f95f0/attachment.sig>
