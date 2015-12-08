From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Dec 2015 12:11:37 -0800
Subject: [PATCH 02/10] clk: ti: Add few dm814x clock aliases
In-Reply-To: <56672ED0.4050405@ti.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-3-git-send-email-tony@atomide.com>
 <20151208165732.GY23396@atomide.com> <56672ED0.4050405@ti.com>
Message-ID: <20151208201136.GZ23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [151208 11:25]:
> On 12/08/2015 06:57 PM, Tony Lindgren wrote:
> >
> >Anybody from the clock department care to ack this one?
> 
> Sorry been rather busy lately...
>
> >I'd like to
> >get this series into Linux next as it fixes some some issues.
> 
> Yeah looks good to me, don't have access to dm814x so can't test.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks.

> Are you planning to push this via omap tree if this is critical for you?

Yes this series needs to be merged in certain order to keep t410
booting. Should not conflict with anything else AFAIK.

Regards,

Tony
