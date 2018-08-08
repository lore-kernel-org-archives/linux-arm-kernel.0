From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Wed, 8 Aug 2018 11:26:05 -0500
Subject: [PATCH 00/33] net: ethernet: Mark expected switch fall-throughs
In-Reply-To: <20180807.175931.200772329178253653.davem@davemloft.net>
References: <cover.1533675546.git.gustavo@embeddedor.com>
 <20180807.175931.200772329178253653.davem@davemloft.net>
Message-ID: <620f18c0-7329-f808-43bc-0f51def3b92a@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/7/18 7:59 PM, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Date: Tue, 7 Aug 2018 18:09:00 -0500
> 
>> In preparation to enabling -Wimplicit-fallthrough, this patchset aims
>> to add some annotations in order to mark switch cases where we are
>> expecting to fall through.
> 
> Ok, I went through all of these and they look good.
> 
> If any are not correct we can revert/fix.
> 

Yep. If anything is reported, I'll take a look right away.

> Series applied, thanks.
> 

Thanks
--
Gustavo
