From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 21 Oct 2014 11:54:16 +0200
Subject: [PATCH 1/2] regulator: max77686: Implement suspend disable for
 some LDOs
In-Reply-To: <1413884182.26980.12.camel@AMDC1943>
References: <1413879912-26606-1-git-send-email-k.kozlowski@samsung.com>
 <1413879912-26606-2-git-send-email-k.kozlowski@samsung.com>
 <54462304.8050602@collabora.co.uk> <1413884182.26980.12.camel@AMDC1943>
Message-ID: <54462D48.2070702@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/21/2014 11:36 AM, Krzysztof Kozlowski wrote:
> On wto, 2014-10-21 at 11:10 +0200, Javier Martinez Canillas wrote:
>> 
>> In general, could you please take a look to the latest patches I posted for the
>> max77802? They are in a topic branch in Mark's regulator tree [1]. I would like
>> both 77686 and 77802 drivers to handle things similarly even though I know that
>> the PMICs don't behave identically and that's why we decided to have different
>> drivers (although maybe that was a mistake and makes more sense to merge them).
> 
> I looked at them. In this patchset I didn't want to implement fully the
> whole suspend-mode-thing. Just the first, easier part - set suspend
> disable.
> 

Agreed, incremental support makes sense to me as well.

I also want to configure the regulator modes in suspend for the Snow Chromebook
using the same modes that are in the downstream Chrome OS tree and I think your
changes will be enough for that too.

> In general I would like to do it similar to your solution but that is
> work for future. Especially as I would like to wait for merging your
> "Add max77802 regulator operating mode support".
> 

Perfect, thanks a lot for working on this!

> Best regards,
> Krzysztof
> 

Best regards,
Javier
