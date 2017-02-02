From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Feb 2017 17:12:34 +0100
Subject: [PATCHv2 net-next 00/11] net: mvpp2: misc improvements and
 preparation patches
In-Reply-To: <20161229.120337.1969688544622629585.davem@davemloft.net>
References: <1482943567-12483-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20161229.120337.1969688544622629585.davem@davemloft.net>
Message-ID: <20170202171234.00b0f21d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Thu, 29 Dec 2016 12:03:37 -0500 (EST), David Miller wrote:

> You still have warnings to fix for the 64-bit build:
> 
> drivers/net/ethernet/marvell/mvpp2.c: In function ?mvpp2_rx?:
> drivers/net/ethernet/marvell/mvpp2.c:5125:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    data = (void *)rx_desc->buf_cookie;
>           ^

Indeed, sorry about that. The warning did not exist with both series
applied, but did exist with just the first series.

I've fixed that up in my v3 of the first series.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
