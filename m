From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 12 Jan 2018 08:30:09 +0100
Subject: [PATCH net-next v4 0/4] net: mvpp2: 1000BaseX and 2500BaseX
 support
In-Reply-To: <20180111.113203.1899608306187914852.davem@davemloft.net>
References: <20180110155808.3484-1-antoine.tenart@free-electrons.com>
 <20180111.112337.98385023847631863.davem@davemloft.net>
 <20180111.113203.1899608306187914852.davem@davemloft.net>
Message-ID: <20180112073009.GC3100@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Jan 11, 2018 at 11:32:03AM -0500, David Miller wrote:
> 
> Actually, this introduced build warnings, I'm reverting.  Please fix this
> and repost.

The warning points a real issue. I'm sorry about that, seems like I
forgot to test this one after the last change... I'll send a new
(tested) version.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
