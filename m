From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Jul 2014 14:10:48 +0200
Subject: [PATCHv3 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
In-Reply-To: <002101cf9c35$8da5b240$a8f116c0$%jun@samsung.com>
References: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
 <1404976119-10777-6-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFoQ_ER7FAk_jCBURAa3_hVT25GXfQQfiDhMoYypdA=fHg@mail.gmail.com>
 <53BE5F9F.6070809@samsung.com>
 <CAPDyKFrLJJn=SGpjtCq+x88EetBQQBCqgef9z9+3oEVut4upTg@mail.gmail.com>
 <002101cf9c35$8da5b240$a8f116c0$%jun@samsung.com>
Message-ID: <CAPDyKFo4gC8Mmbt+f88EMqGvPH9hqW4Fw9d05hq3YGB=iFgaXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2014 13:53, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Thu, July 10, 2014, Ulf Hansson wrote:
>> On 10 July 2014 11:40, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> > Hi, Ulf.
>> >
>> > On 07/10/2014 06:15 PM, Ulf Hansson wrote:
>> >> On 10 July 2014 09:08, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> >>> Replaced the "disable-wp" into host's quirks.
>> >>> (Because the slot-node is removed at dt-file.)
>> >>>
>> >>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> >>
>> >> Hi Jaehoon,
>> >>
>> >> I plan to carry these patches through my mmc tree and I will share
>> >> them through a PR from an immutable branch with the ARM SoC guys.
>> >> Please tell me if you have any concern with this set up.
>>
>> Hmm, I having a second thought around this. Could I just apply the mmc
>> patches for my next branch instead of involving ARM SoC? In other
>> words, are there any decencies? If not, I might just apply patch 1 and
>> 5.
>>
>
> [PATCHv4 2/5] ARM: dts: exynos: unuse the slot-node and deprecated the supports-highspeed for dw-mmc
> [PATCHv4 4/5] ARM: dts: rockchip: unuse the slot-node and deprecated the supports-highspeed for dw-mmc
> [PATCHv4 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk to host's quirk
>
> 2nd and 4th are closely related 5th.
> I think it shall be picked together. How about taking whole patch?
> And I hope that it is applied for 3.16-rcX fix.
> (Also, 3rd patch is close to fix patch.)
>
> Kukjin,
> Is it fine to be taken in Ulf's?

I tried applied the complete patchset for 3.16 rc4, but some of the
DTS patches fails. What are these patches based upon?

I wonder if it's not best to leave all these for Kukjin to handle
instead. You have my ack for all of the mmc patches!

Kind regards
Uffe
