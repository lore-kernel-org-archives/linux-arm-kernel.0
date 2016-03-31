From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 31 Mar 2016 11:31:56 +0100
Subject: Boot failure on i.MX6 boards due to commit 5e3ca2b349b1
 ("regulator: Try to resolve regulators supplies on registration")
In-Reply-To: <20160331122149.56281b0d@ipc1.ka-ro>
References: <20160331122149.56281b0d@ipc1.ka-ro>
Message-ID: <56FCFC9C.7080305@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 31/03/16 11:21, Lothar Wa?mann wrote:
> Hi,
> 
> booting a TX6 module (i.MX6Q or i.MX6DL) fails with current linux-next.
> Bisecting revealed the culprit to be commit:
> 5e3ca2b349b1 (""regulator: Try to resolve regulators supplies on registration)
> 
> Reverting this commit on top of next-20163031 makes the board functional again.

Can you try today's -next? I posted a fix for this yesterday which
should now be included [0].

Cheers
Jon

[0] http://marc.info/?l=linux-kernel&m=145935417601025&w=2
