From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 03 Aug 2015 17:37:28 +0200
Subject: [PATCH v2 14/15] KVM: arm64: implement MSI injection in ITS
 emulation
In-Reply-To: <00f101d0cdcd$146a6090$3d3f21b0$@samsung.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-15-git-send-email-andre.przywara@arm.com>
 <55BB7678.5080105@linaro.org> <55BE7BA1.40403@arm.com>
 <00a201d0cdb7$70a623f0$51f26bd0$@samsung.com> <55BF2F51.6020701@linaro.org>
 <00f101d0cdcd$146a6090$3d3f21b0$@samsung.com>
Message-ID: <55BF8AB8.5050408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andre, Pavel,
On 08/03/2015 11:16 AM, Pavel Fedin wrote:
>  Hello!
> 
>> Again the case that leaves me uncomfortable is the one where the
>> userspace does not provide the devid whereas it must (GICv3 ITS case).
> 
>  Hypothetical broken userland which does not exist for now ?
Yes but that's the rule to be not confident in *any* userspace, isn't it?

As of now I prefer keeping the flags at uapi level and propagate it
downto the kernel, as long as I don't have any answer for the unset
devid discrimination question. Please apologize for my stubbornness ;-)

Best Regards

Eric


>  IMHO the userland should just know, that if it supports ITS, it has to provide devIDs.
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
