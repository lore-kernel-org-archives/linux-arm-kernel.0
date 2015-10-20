From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 17:27:58 +0900
Subject: [PATCH v4 6/8] drivers: soc: add support for exynos SROM driver
In-Reply-To: <021201d10b0f$b273bf00$175b3d00$@samsung.com>
References: <1445255206-11148-1-git-send-email-pankaj.dubey@samsung.com>
 <1445255206-11148-7-git-send-email-pankaj.dubey@samsung.com>
 <56258683.7070204@samsung.com> <5625B92C.10505@samsung.com>
 <5625C07D.4030706@samsung.com> <014301d10b01$488873f0$d9995bd0$@samsung.com>
 <5625E3B9.8040707@samsung.com> <021201d10b0f$b273bf00$175b3d00$@samsung.com>
Message-ID: <5625FB0E.2000109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 17:17, Pavel Fedin wrote:
>  Hello!
> 
>>>  Pin controller is needed in order to configure multi-functional pins correctly.
>>
>> Are there any obstacles for upstreaming it?
> 
>  I don't know. The last post on this topic is from March, 2015:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html. Patch 0003 has been acked-by, and nothing more since
> that.
>  Actually, only 0002 and 0003 of this series are needed for the pin controller. 0001 has been accepted
> (27284129522e7e2a5b89e80bd44ea3345f79c9e8).

I see that all objections were solved and I already reviewed all of the
patches. This was sent before I started collecting patches as
co-maintainer so all it is needed now is to rebase and resend with
collected tags.

I'll try to find them in my archives and apply.

Really, if you have anything waiting then just resend/ping. Things
changed since May this year :) .

Best regards,
Krzysztof
