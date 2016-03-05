From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 5 Mar 2016 13:35:19 +0900
Subject: [PATCH 0/2] [media] exynos4-is: Trivial fixes for DT
 port/endpoint parse logic
In-Reply-To: <1457122813-12791-1-git-send-email-javier@osg.samsung.com>
References: <1457122813-12791-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CAJKOXPfOpqU2fGsNNaB6n_iuq2r-8z3TCSsqkncPbvkK2344Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-05 5:20 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> Hello,
>
> This series have two trivial fixes for issues that I noticed while
> reading as a reference the driver's functions that parse the graph
> port and endpoints nodes.
>
> It was only compile tested because I don't have access to a Exynos4
> hardware to test the DT parsing, but the patches are very simple.

Not directly related, but similar: my previous two patches for missing
of_node_put [0] are unfortunately still waiting. Although I have
Exynos4 boards, but I don't have infrastructure/scripts to test it.

Best regards,
Krzysztof

[0] https://patchwork.linuxtv.org/patch/32707/
