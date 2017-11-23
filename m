From: davem@davemloft.net (David Miller)
Date: Fri, 24 Nov 2017 03:39:36 +0900 (KST)
Subject: [PATCH net v2] net: thunderx: Fix TCP/UDP checksum offload for
 IPv6 pkts
In-Reply-To: <20171123144158.26111-1-aleksey.makarov@auriga.com>
References: <20171123144158.26111-1-aleksey.makarov@auriga.com>
Message-ID: <20171124.033936.1934188261920003091.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <aleksey.makarov@auriga.com>
Date: Thu, 23 Nov 2017 17:41:56 +0300

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> Don't offload IP header checksum to NIC.
> 
> This fixes a previous patch which enabled checksum offloading
> for both IPv4 and IPv6 packets.  So L3 checksum offload was
> getting enabled for IPv6 pkts.  And HW is dropping these pkts
> as it assumes the pkt is IPv4 when IP csum offload is set
> in the SQ descriptor.
> 
> Fixes: bbbb494fd005 ("net: thunderx: Enable TSO and checksum offloads for ipv6")

This fixes tag contains an invalid GIT SHA1-ID.

Please fix this up.
