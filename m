From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 30 Aug 2017 21:06:25 -0700
Subject: [net-next PATCHv6 0/2] net: ethernet: Socionext Netsec
In-Reply-To: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
References: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <27A7C5A5-AFF4-49F3-B0DF-7F53283EC2A4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 30, 2017 3:24:17 AM PDT, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>Hello,
>
>The OGMA/Netsec controller is used in latest SoC from
>Socionext/Fujitsu.
>
>I am refreshing the patchset by basically using official name of the IP
>from 'OGMA' to 'Netsec'. And the company is renamed too, from Fujitsu
>to Socionext to better reflect the reality.
>
> I have addressed comments (that could be) on the last revision -->
>https://patchwork.kernel.org/patch/4540651/
>
> Of course, I have scanned changes to the drivers/net/ethernet since
>last submission and integrated whichever applicable and rebased the
>driver on top of last rc.

It does not appear to be at first glance, but I will just ask anyways, this is not yet another variant of stmmac glued just a little bit differently into the SoC right?

Will take a closer look at the register set and driver tomorrow. Thanks

-- 
Florian
