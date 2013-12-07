From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 07 Dec 2013 12:06:03 +0100
Subject: [PATCH 02/10] net: stmmac: Honor DT parameter to force DMA store
 and forward mode
In-Reply-To: <20131207100737.GI24519@lukather>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <CAGb2v67ZNtbQm+ZW5v_3wNbz1=oLhXks6gbTSjLYa=Nnoz8w-A@mail.gmail.com>
 <20131207100737.GI24519@lukather>
Message-ID: <2994980.boLDbkkER8@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 of December 2013 11:07:37 maxime.ripard wrote:
> On Sat, Dec 07, 2013 at 09:23:27AM +0800, Chen-Yu Tsai wrote:
> > Point taken. The current implementation will override settings passed from
> > platform data. ORing the two would be better.
> 
> Platform_data and DT-based configuration are pretty unlikely to be
> used together, so ORing it doesn't have much sense.

In fact, the recommended way is to always use platform data alone if it is
present or try to parse DT otherwise, so no mixing of data from these two
sources should be done.

Best regards,
Tomasz
