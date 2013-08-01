From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Aug 2013 16:30:36 -0700
Subject: [PATCH V3 3/3] ethernet: Convert mac address uses of 6 to ETH_ALEN
In-Reply-To: <9ab1185f349544b160632bfec566391928fa0768.1375398692.git.joe@perches.com>
References: <cover.1375398692.git.joe@perches.com>
 <20130801.143137.331385226409040561.davem@davemloft.net>
 <9ab1185f349544b160632bfec566391928fa0768.1375398692.git.joe@perches.com>
Message-ID: <CAOesGMjDgH-uRsjd1g2R_aTjUsPPLge17X2hBPogVv6ZFd_LnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 4:17 PM, Joe Perches <joe@perches.com> wrote:
> Use the normal #define to help grep find mac addresses
> and ensure that addresses are aligned.
>
> pasemi.h has an unaligned access to mac_addr, unchanged
> for now.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Olof Johansson <olof@lixom.net> # pasemi_mac pieces


-Olof
