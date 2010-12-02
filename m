From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Wed, 1 Dec 2010 19:36:34 -0600
Subject: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
In-Reply-To: <1291231567-notmuch-felipe.contreras@nokia.com>
References: <1288033806-1496-1-git-send-email-x0095840@ti.com>
	<20101129.104729.97149649.Hiroshi.DOYU@nokia.com>
	<1291231567-notmuch-felipe.contreras@nokia.com>
Message-ID: <AANLkTimQcXrgxGjZonSUSkXqoHfAVVhXuHnGKBkMKc9X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 1, 2010 at 1:27 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> Hiroshi.DOYU at nokia.com wrote:
>> From: ext Fernando Guzman Lugo <x0095840@ti.com>
>> Subject: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
>> Date: Mon, 25 Oct 2010 21:10:02 +0200
>>
>> > Version 5:
>> > * Changes in "iommu: create new api to set valid da range"
>> > ? - Change range variables to platform data structure.
>>
>> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Does that means you are going to send a pull request with these for .38?
>
> Fernando, is there a branch where you have all the changes needed in
> tidspbridge?

No, I dont have that branch.

>
> I guess the only patch missing would be the one for linux-arm.

Yes, after merging them, the only missing is the SG chain patch.

Regards,
Fernando.

>
> Cheers.
>
> --
> Felipe Contreras
>
