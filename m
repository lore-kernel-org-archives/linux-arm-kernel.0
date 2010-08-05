From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 5 Aug 2010 11:06:18 +0800
Subject: [PATCH] [ARM] pxa/cm-x300: fix ffuart registration
In-Reply-To: <20100804170657.GD28217@suse.de>
References: <1279612732-5906-1-git-send-email-grinberg@compulab.co.il>
	<AANLkTikxIFryvGJeCRMPrGrdcPXaEDPjsgEozsHbndwR@mail.gmail.com>
	<4C556422.3060901@compulab.co.il>
	<AANLkTimiriUNY+NyOz5vwLzX05zUjxojbCaDgQrbw+1J@mail.gmail.com>
	<20100804170657.GD28217@suse.de>
Message-ID: <AANLkTimpt9mLsZ5Yiufxp=PPcGEOtW8+EAueh7b=UMNu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 5, 2010 at 1:06 AM, Greg KH <gregkh@suse.de> wrote:
> On Wed, Aug 04, 2010 at 11:37:33AM +0800, Eric Miao wrote:
>> On Sun, Aug 1, 2010 at 8:10 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> > On 07/20/10 13:54, Eric Miao wrote:
>> >> On Tue, Jul 20, 2010 at 9:58 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> >>
>> >>> ffuart is available on cm-x300 only with pxa300.
>> >>>
>> >>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> >>>
>> >> Applied.
>> >>
>> >
>> > I can see it neither in fix, nor in devel branches on your git.kernel.org.
>> > Do you keep it locally?
>>
>> Sorry it's in my local tree and missed the -rc phase. I'll push it within
>> this merge window. Cc'ed stable and GregKH.
>>
>> Greg,
>>
>> Could you help pick this simple oneliner to -stable? Or we'd better
>> wait a while until this appears in Linus' tree?
>
> I am not allowed to take a patch in the stable tree unless it is already
> in Linus's tree, sorry.
>
> So I'll have to wait until then. ?You do know about adding a:
> ? ? ? ?Cc: stable <stable@kernel.org>
> to the signed-off-by area in the patch which will automatically notify
> me when it goes into Linus's tree to be picked up for the next stable
> releases, right?
>

OK, thanks.

> thanks,
>
> greg k-h
>
