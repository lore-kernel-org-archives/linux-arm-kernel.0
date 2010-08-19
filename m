From: davem@davemloft.net (David Miller)
Date: Thu, 19 Aug 2010 00:15:13 -0700 (PDT)
Subject: [PATCH net-next-2.6] atm: remove a net_device_stats clear
In-Reply-To: <1282164274.2328.2.camel@edumazet-laptop>
References: <20100818083304.2ef2eea4@nehalam>
	<20100818.131043.226780154.davem@davemloft.net>
	<1282164274.2328.2.camel@edumazet-laptop>
Message-ID: <20100819.001513.212394625.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 18 Aug 2010 22:44:34 +0200

> Le mercredi 18 ao?t 2010 ? 13:10 -0700, David Miller a ?crit :
>> Yep, both the ether1 and ether3 patch have this problem.  Looks
>> like we'll see v4 coming some :-)
> 
> To be fair, we accepted some bits like that in the past ;)

Yes, but let's nip it in the butt immediately when we do
notice it :-)

> [PATCH net-next-2.6] atm: remove a net_device_stats clear
> 
> No need to clear device stats in lec_open()
> 
> Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>

Applied, thanks!
