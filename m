From: davem@davemloft.net (David Miller)
Date: Wed, 02 May 2018 11:06:17 -0400 (EDT)
Subject: [PATCH net-next v2 00/15] ARM: sun8i: r40: Add Ethernet support
In-Reply-To: <CAGb2v67HFb6eLBS4_9s_wJ5uWFeQdUtwn_NMJnm59UUDFBDJUA@mail.gmail.com>
References: <20180501161227.2110-1-wens@csie.org>
 <CAGb2v67HFb6eLBS4_9s_wJ5uWFeQdUtwn_NMJnm59UUDFBDJUA@mail.gmail.com>
Message-ID: <20180502.110617.304411895589508709.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 May 2018 00:33:45 +0800

> I should've mentioned that patches 3 ~ 10, and only these, should go
> through net-next. sunxi will handle the remaining clk, device tree, and
> soc driver patches.

Ok, I just noticed this.

Why don't you just post those patches separately as a series on their
own then, in order to avoid confusion?

Then you can adjust the patch series header posting to explain the
non-net-next changes, where they got merged, and what they provide
in order to faciliate the net-next changes.

Thanks.
