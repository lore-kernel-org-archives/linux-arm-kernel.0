From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Feb 2012 21:31:56 -0200
Subject: [PATCH RESEND] FEC: Rename dev to ndev, fix compile error
In-Reply-To: <1328654643-28442-1-git-send-email-marek.vasut@gmail.com>
References: <1328654643-28442-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <CAOMZO5Dq4o9BWfsL97awSaxeqHrLZK5GYb+JS1cpghSeaEfYYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Feb 7, 2012 at 8:44 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The following commit introduced a typo, this commit fixes it.
>
> commit 21a4e46995fa1a76281ac0281ff837f706231a37
> Author: Pradeep A Dalvi <netdev@pradeepdalvi.com>
> Date: ? Sun Feb 5 02:50:10 2012 +0000
>
> ? ?netdev: ethernet dev_alloc_skb to netdev_alloc_skb
>
> ? ?Replaced deprecating dev_alloc_skb with netdev_alloc_skb in drivers/net/ethernet
> ? ? ?- Removed extra skb->dev = dev after netdev_alloc_skb
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Pradeep A Dalvi <netdev@pradeepdalvi.com>
> Cc: David S. Miller <davem@davemloft.net>

I have already sent a fix for this issue and David has applied it.

Regards,

Fabio Estevam
