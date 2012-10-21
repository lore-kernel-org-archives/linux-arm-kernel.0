From: davem@davemloft.net (David Miller)
Date: Sun, 21 Oct 2012 19:27:07 -0400 (EDT)
Subject: [PATCH 1/5] net/cadence: get rid of HAVE_NET_MACB
In-Reply-To: <1350829392-3812-2-git-send-email-manabian@gmail.com>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
 <1350829392-3812-2-git-send-email-manabian@gmail.com>
Message-ID: <20121021.192707.1747557282711878897.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


You do know that this is going to generate warnings on 64-bit
platforms?

I was hoping you would have noticed and corrected this before
enabling the driver everywhere, I guess my expectations were
way too high :-/
