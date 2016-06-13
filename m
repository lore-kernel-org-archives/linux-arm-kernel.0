From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Mon, 13 Jun 2016 21:58:39 +0300
Subject: [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime functions
 when not needed.
In-Reply-To: <20160613071057.GQ22406@atomide.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509193624.GH5995@atomide.com> <5730F840.3050807@gmail.com>
 <20160610102225.GS22406@atomide.com> <575B2F48.4090707@gmail.com>
 <20160613071057.GQ22406@atomide.com>
Message-ID: <575F025F.7000101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13.06.2016 10:10, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160610 14:23]:
>>
>> On 10.06.2016 13:22, Tony Lindgren wrote:
>>>
>>> OK. And I just applied the related dts changes. Please repost the driver
>>> changes and DT binding doc with Rob's ack to the driver maintainers to
>>> apply.
>>>
>>
>> Already did, see https://lkml.org/lkml/2016/5/16/429
>>
>> Shall I do anything else?
>
> Probably good idea to repost just the driver changes to the
> subsystem maintainers. With v4.7 out any pre v4.7 patchsets
> easily get forgotten.
>

Sorry for the maybe stupid question, but does this mean that I should 
send separate patches instead of series? Or the series without what 
you've already applied?

Thanks,
Ivo
