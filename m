From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 13:39:07 +0100
Subject: [PATCH V3 1/4] ARM: smp_twd: Fix typo in 'twd_timer_rate' printing
In-Reply-To: <1310041396-2461-1-git-send-email-vkuzmichev@mvista.com>
References: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
	<1310041396-2461-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <20110707123907.GP8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:23:13PM +0400, Vitaly Kuzmichev wrote:
> To get hundredths of MHz the rate needs to be divided by 10'000.
> Here is an example:
>  twd_timer_rate = 123456789
>  Before the patch:
>     twd_timer_rate / 1000000 = 123
>     (twd_timer_rate / 1000000) % 100 = 23
>     Result: 123.23MHz.
>  After being fixed:
>     twd_timer_rate / 1000000 = 123
>     (twd_timer_rate / 10000) % 100 = 45
>     Result: 123.45MHz.
> 
> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>

-> patch system please.

Thanks.
