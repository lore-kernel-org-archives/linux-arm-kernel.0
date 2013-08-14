From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 10:09:43 -0600
Subject: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
In-Reply-To: <20130814052940.GC16635@quad.lixom.net>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
 <52096C75.1030305@wwwdotorg.org> <20130814052940.GC16635@quad.lixom.net>
Message-ID: <520BABC7.8010100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2013 11:29 PM, Olof Johansson wrote:
> On Mon, Aug 12, 2013 at 05:15:01PM -0600, Stephen Warren wrote:
>> On 08/08/2013 04:55 PM, dinguyen at altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
>>> and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
>>> just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.
>>
>> But the properties aren't globally standard; they apply specifically
>> anywhere that this particular Synopsis IP is present. As such, I think
>> at least a "synopsis," prefix is warranted.
> 
> A prefix is only really needed when a vendor is making a vendor-specific
> extension on a shared binding. Since the whole binding is
> synopsis-specific, I don't think there's need for a prefix here.

Oh! That definitely isn't the rule that's been applied before; I've been
asked to add "nvidia," prefixes to properties in entirely custom bindings...
