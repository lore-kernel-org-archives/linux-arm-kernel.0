From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 10 Jun 2011 16:38:47 +0530
Subject: [PATCH 1/8] OMAP2+: clockdomain: Add an api to read idle mode
In-Reply-To: <20110610000715.GA9059@google.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
	<20110610000715.GA9059@google.com>
Message-ID: <4DF1FB3F.1040906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/10/2011 5:37 AM, Todd Poynor wrote:
> On Thu, Jun 09, 2011 at 04:24:06PM +0530, Rajendra Nayak wrote:
>> Add a clockdomain api to check if hardware supervised
>> idle transitions are enabled on a clockdomain.
>>
> ...
>> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled
>
> A minor suggestion on naming: "clkdm_allows_idle" seems more accurate
> and a natural complement to the existing clkdm_allow_idle().

Yeah, I agree. I'll change it in my next spin.

Thanks,
Rajendra
>
>
> Todd
