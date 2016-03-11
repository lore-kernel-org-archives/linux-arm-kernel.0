From: davem@davemloft.net (David Miller)
Date: Fri, 11 Mar 2016 14:20:22 -0500 (EST)
Subject: [PATCH net 3/3] net: mvneta: fix error messages in
 mvneta_port_down function
In-Reply-To: <1457441826-6100-4-git-send-email-gregory.clement@free-electrons.com>
References: <1457441826-6100-1-git-send-email-gregory.clement@free-electrons.com>
 <1457441826-6100-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160311.142022.1421480365252928267.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Tue,  8 Mar 2016 13:57:06 +0100

> From: Dmitri Epshtein <dima@marvell.com>
> 
> This commit corrects error printing when shutting down the port. Also
> magic numbers are replaced by existing macros.
> 
> Signed-off-by: Dmitri Epshtein <dima@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Individual patches should do one thing, rather than several at once.

Please split this up into two changes, thanks.
