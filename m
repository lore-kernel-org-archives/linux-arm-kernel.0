From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 14:56:00 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <1405504062.4408.11.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <1405504062.4408.11.camel@x220>
Message-ID: <53C67660.8050003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2014 11:47, Paul Bolle wrote:
> On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:

[snip]

>>  config SAMSUNG_GPIO_EXTRA
>>  	int "Number of additional GPIO pins"
>>  	default 128 if SAMSUNG_GPIO_EXTRA128
> 
> So a second order effect is that SAMSUNG_GPIO_EXTRA can now be removed.
> Which implies that SAMSUNG_GPIO_EXTRA64 and SAMSUNG_GPIO_EXTRA128 can
> also be removed.
> 
> Should I submit the trivial patch to do that or is a patch already
> queued somewhere?

Please do if you don't mind. That's one more thing I missed.

Best regards,
Tomasz
