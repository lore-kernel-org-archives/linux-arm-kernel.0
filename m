From: james.morse@arm.com (James Morse)
Date: Thu, 15 Oct 2015 11:04:16 +0100
Subject: [PATCH v2 7/7] arm64: allow kernel Image to be loaded anywhere
 in physical memory
In-Reply-To: <CAKv+Gu_tfE4SLi2PONW8hLDL8VMW58OaLc1JG1KYjWK4gb0AWA@mail.gmail.com>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>	<1442968663-31843-8-git-send-email-ard.biesheuvel@linaro.org>	<561E3CBF.60704@arm.com>	<CAKv+Gu-8i5ktTxBn6kW=cEppoW-CYnJqxrgKFeuutAUtTXoA1w@mail.gmail.com>	<20151014163415.GI4239@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_tfE4SLi2PONW8hLDL8VMW58OaLc1JG1KYjWK4gb0AWA@mail.gmail.com>
Message-ID: <561F7A20.8010704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 17:51, Ard Biesheuvel wrote:
> On 14 October 2015 at 17:34, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Wed, Oct 14, 2015 at 02:25:58PM +0100, Ard Biesheuvel wrote:
>>> I will take this into account when I spin the next version (probably
>>> after 16k pages support is merged)
>>
>> I plan to merge 16K pages support in 4.4, waiting for the review to
>> settle and I'll queue them.
>>
>> BTW, have you tested these patches with KVM? We were wondering if the
>> stage 1 hyp mapping gets confused.
>>
> 
> I honestly don't remember, so consider that a 'no'. I will look into
> it before reposting.

I still had this set up:
Guests with and without this series both boot fine on a host with this series.


Thanks,

James
