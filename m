From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Sat, 7 Dec 2013 11:07:37 +0100
Subject: [PATCH 02/10] net: stmmac: Honor DT parameter to force DMA store
 and forward mode
In-Reply-To: <CAGb2v67ZNtbQm+ZW5v_3wNbz1=oLhXks6gbTSjLYa=Nnoz8w-A@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-3-git-send-email-wens@csie.org>
 <20131206.162606.2277176361893801778.davem@davemloft.net>
 <CAGb2v67ZNtbQm+ZW5v_3wNbz1=oLhXks6gbTSjLYa=Nnoz8w-A@mail.gmail.com>
Message-ID: <20131207100737.GI24519@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 07, 2013 at 09:23:27AM +0800, Chen-Yu Tsai wrote:
> Point taken. The current implementation will override settings passed from
> platform data. ORing the two would be better.

Platform_data and DT-based configuration are pretty unlikely to be
used together, so ORing it doesn't have much sense.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131207/2bf76035/attachment.sig>
