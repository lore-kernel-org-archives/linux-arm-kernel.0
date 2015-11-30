From: menon.nishanth@gmail.com (Nishanth Menon)
Date: Mon, 30 Nov 2015 07:36:26 -0600
Subject: [PATCH 01/18] ARM: am57xx: cl-som-am57x: dts: add basic module
 support
In-Reply-To: <565C4F54.50405@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il>
 <565629D2.2010401@ti.com> <565AEB19.4050107@compulab.co.il>
 <565B307E.2000203@ti.com> <565C4F54.50405@compulab.co.il>
Message-ID: <565C50DA.4010901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 07:29 AM, Dmitry Lifshitz wrote:
> On 11/29/2015 07:06 PM, Nishanth Menon wrote:
>> On 11/29/2015 06:10 AM, Dmitry Lifshitz wrote:
[...]
>>
>> You might want to ask your TI support contact for IODelay
>> recommendations. TRM mentions that pinmuxing must be performed under IO
>> isolation. There are silicon constraints in DRA7/AM57xx family, which
>> were not present previously.
>>
> 
> Ok. I understand. This might take time...
> Since we'd like to have this in for 4.5, what would you recommend?
> Should I drop the muxes from this patch set? All the muxes?
> Or should we merge this (as it works correctly) in our tests and check
> on this later after investigation with TI?
> 
> Also, in theory, there might be pins shared between two or more
> different functionalities and remuxed during runtime.
> Can this kind of thing be supported on AM57x?

This is why I suggested to talk and confirm with TI support contact on
this. I understand the motivation of SoM concept, but this requires some
careful designing around.


-- 
Regards,
Nishanth Menon
