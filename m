From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 10 Jan 2014 23:42:41 +0300
Subject: [PATCH 1/1] drivers: net: silence compiler warning in smc91x.c
In-Reply-To: <1389323046-4521-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389323046-4521-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <52D05B41.7000601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/10/2014 06:04 AM, Pankaj Dubey wrote:

> If used 64 bit compiler GCC warns that:

> drivers/net/ethernet/smsc/smc91x.c:1897:7:
> warning: cast from pointer to integer of different
> size [-Wpointer-to-int-cast]

> This patch fixes this by changing typecase from "unsigned int" to "unsigned long"

    Only "typecast".

> CC: "David S. Miller" <davem@davemloft.net>
> CC: Jingoo Han <jg1.han@samsung.com>
> CC: netdev at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

WBR, Sergei
