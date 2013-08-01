From: davem@davemloft.net (David Miller)
Date: Thu, 01 Aug 2013 15:51:59 -0700 (PDT)
Subject: [PATCH v4] net: Add MOXA ART SoCs ethernet driver
In-Reply-To: <1375349968-16059-1-git-send-email-jonas.jensen@gmail.com>
References: <1375280401-5564-1-git-send-email-jonas.jensen@gmail.com>
 <1375349968-16059-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130801.155159.1229408467464868669.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Thu,  1 Aug 2013 11:39:28 +0200

>     I have since found a problem occurring on high load. Please point out
>     anything the driver can do differently to eliminate it.
>     
>     The error only occurs during external ping, i.e. ping -s 50000 from
>     10.0.1.200 to hardware.

Looks like pure memory corruption.
