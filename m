From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 30 Apr 2011 03:27:07 +0200
Subject: AT91: Convert RTC and RTT drivers to be independent of
	processor base-address
In-Reply-To: <1304106068.25025.8.camel@redbox>
References: <1304106068.25025.8.camel@redbox>
Message-ID: <20110430012707.GA1212@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:41 Fri 29 Apr     , Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> following changes to the RTC and RTT driver support:
>  * pass base addresses via platform resources
>  * replace calls to at91_sys_read() / at91_sys_write()
>  * rename AT91_RTT/AT91_RTC to AT91xxx_RTT/AT91xxx_RTC to denote they
> are processor-specific.
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>
I work on similar patch

but here we have an issue we need to pas the GPBR resource also

Best Regards,
J.
