From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 26 Oct 2012 15:45:40 +0530
Subject: [PATCH] ARM: davinci: dm644x: move the dereference below the
 NULL test
In-Reply-To: <CAPgLHd81OwYR65x56Fe1+hcWQsK1wiA6+MQYLBwvP59o-kH8QA@mail.gmail.com>
References: <CAPgLHd81OwYR65x56Fe1+hcWQsK1wiA6+MQYLBwvP59o-kH8QA@mail.gmail.com>
Message-ID: <508A62CC.8070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/10/2012 10:19 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The dereference should be moved below the NULL test.
> 
> spatch with a semantic match is used to found this.
> (http://coccinelle.lip6.fr/)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Queuing this for inclusion in v3.8

Thanks,
Sekhar
