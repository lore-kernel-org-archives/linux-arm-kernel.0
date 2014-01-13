From: davem@davemloft.net (David Miller)
Date: Mon, 13 Jan 2014 11:54:59 -0800 (PST)
Subject: [PATCH 1/1] drivers: net: silence compiler warning in smc91x.c
In-Reply-To: <52D05B41.7000601@cogentembedded.com>
References: <1389323046-4521-1-git-send-email-pankaj.dubey@samsung.com>
 <52D05B41.7000601@cogentembedded.com>
Message-ID: <20140113.115459.326248442934302460.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 10 Jan 2014 23:42:41 +0300

> Hello.
> 
> On 01/10/2014 06:04 AM, Pankaj Dubey wrote:
> 
>> If used 64 bit compiler GCC warns that:
> 
>> drivers/net/ethernet/smsc/smc91x.c:1897:7:
>> warning: cast from pointer to integer of different
>> size [-Wpointer-to-int-cast]
> 
>> This patch fixes this by changing typecase from "unsigned int" to
>> "unsigned long"
> 
>    Only "typecast".

Applied with this typo fixed, thanks.
