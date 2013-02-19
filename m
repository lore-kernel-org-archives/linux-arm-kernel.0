From: wni@nvidia.com (Wei Ni)
Date: Tue, 19 Feb 2013 17:52:35 +0800
Subject: [RFC PATCH 1/9] ARM: dt: t30 cardhu: add dt entry for lm90
In-Reply-To: <5122F162.9030103@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-2-git-send-email-wni@nvidia.com>
 <5122F162.9030103@nvidia.com>
Message-ID: <51234B63.7080104@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 11:28 AM, Alex Courbot wrote:
> On 02/18/2013 08:30 PM, Wei Ni wrote:
>> Enable thermal sensor lm90 in the dts file.
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Btw, shouldn't this patch come last, after all the changes you did to 
> lm90? If you keep the current order, you will need to ensure that the 
> device performs as expected on Cardhu for each of the remaining patches 
> of the series. It is probably safer to just move this one at the end to 
> avoid trouble.

I will try split this patch set into 3 separate sets in my next version,
like Matthew's suggestion, so the patches will be clear.

Wei.

> 
> Alex.
> 
