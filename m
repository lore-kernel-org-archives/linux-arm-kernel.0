From: lmctlx@gmail.com (Karol Lewandowski)
Date: Mon, 23 Jan 2012 20:21:48 +0100
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <20120123182056.GA26409@opensource.wolfsonmicro.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1D9DDE.2070106@samsung.com>
 <20120123182056.GA26409@opensource.wolfsonmicro.com>
Message-ID: <4F1DB34C.4030103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2012 07:20 PM, Mark Brown wrote:
> On Mon, Jan 23, 2012 at 06:50:22PM +0100, Karol Lewandowski wrote:
>
>> Aren't these fixed? i.e. - is it really needed to configure these
>> either by platform data or DT at all?
>>
>>
>> [1]
>>
>>  From 5cfba526210bc596c7d14e33fea93648baa0a227 Mon Sep 17 00:00:00 2001
>> From: Karol Lewandowski<k.lewandowsk@samsung.com>
>
> Documentation/SubmittingPatches please...

I should have stated explicitly that purpose of this patch (I should 
have called it sniplet) was to show my point only.

IMHO it's still up to debate how above problem should be solved.

I'm not entirely sure that we really need things like e.g. "EN32KHz AP" 
in DT (nor in platform data, for that matter).  I would like to see 
Thomas' opinion first.

Thanks

Regards,
Karol Lewandowski
