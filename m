From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 15 Jul 2015 10:15:41 +0900
Subject: [PATCH 1/2] ASoC: Drop owner assignment from i2c_driver
In-Reply-To: <20150714165758.GF11162@sirena.org.uk>
References: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
 <1436506231-8980-2-git-send-email-k.kozlowski@samsung.com>
 <20150714165758.GF11162@sirena.org.uk>
Message-ID: <55A5B43D.9020601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.07.2015 01:57, Mark Brown wrote:
> On Fri, Jul 10, 2015 at 02:30:30PM +0900, Krzysztof Kozlowski wrote:
>> i2c_driver does not need to set an owner because i2c_register_driver()
>> will set it.
> 
> This doesn't apply against current code, please check and resend.

Indeed, I rebased it on linux-next from 8th of July but the release
included changes in the same place in ts3a227e.c.

I'll rebase and resend.

Best regards,
Krzysztof
