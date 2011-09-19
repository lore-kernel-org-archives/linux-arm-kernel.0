From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 19 Sep 2011 16:06:27 +0530
Subject: [PATCH v8 00/16] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1316401174.21359.3.camel@vkoul-udesk3>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1315980099.26251.498.camel@vkoul-udesk3>
	<CABb+yY25NTbtRPOw-KH8U4zA1Bo8q0BDM8SXyrsobG7NEv8edg@mail.gmail.com>
	<1315999032.26251.501.camel@vkoul-udesk3>
	<CAJe_ZhdrPMbBOkfwg=PFyVU14eT0Gc0=rtKwEiQCH5-Q5-CtVQ@mail.gmail.com>
	<1316401174.21359.3.camel@vkoul-udesk3>
Message-ID: <CABb+yY0Gv1=KvpBmYvZO_ux=b0QRssUvXxad5Y4E38OdwnhCxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 8:29 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> >> The changelog for [PATCH v8 04/16] is misleading - we don't need any
>> >> modification for the reason mentioned in changelog. But the modification
>> >> has positive side-effect of preventing callbacks during terminate_all which
>> >> is no way understood from the changelog. So I would like to changelog
>> >> corrected.
>> > I thought change log was correct in depicting what patch does and Boojin
>> > had replied.... I will check again...
>>
>> I didn't reply because I ran out of ways to explain the same thing in
>> different words.
> I checked again the patch, change log and your comments.
> I agree with current change log, and also your observation is right but
> that is just a side effect,
It is not "just a side effect", it is "the only tangible effect".
If it were not for this 'side-effect', the patch would be _purely_ cosmetic
rearrangement.
The _only_ difference seen would be by clients who would no longer
have callbacks when they issue terminate_all.
And I don't think that is expected at all reading the changelog in current form.

> So no changes to this and I a ready to merge it to my next in a day or
> two...
I guess the world isn't gonna come to grinding halt with this changelog.
Please feel free to do what you think is the best.
