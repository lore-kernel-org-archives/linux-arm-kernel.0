From: davem@davemloft.net (David Miller)
Date: Sun, 01 Oct 2017 22:51:59 -0700 (PDT)
Subject: [PATCH v2 net] net: mvpp2: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20170929122739.5296-1-gregory.clement@free-electrons.com>
References: <20170929122739.5296-1-gregory.clement@free-electrons.com>
Message-ID: <20171001.225159.2176517451167649617.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Fri, 29 Sep 2017 14:27:39 +0200

> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied.
