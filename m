From: davem@davemloft.net (David Miller)
Date: Fri, 07 Sep 2018 14:57:17 -0700 (PDT)
Subject: [PATCH 0/5] introduce
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 functions
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180907.145717.248815695221355297.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If you are going to do this, please add for_each_set_bit64() and similar.

For example, see:

https://marc.info/?l=linux-netdev&m=153633391214025&w=2
