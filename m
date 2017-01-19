From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Thu, 19 Jan 2017 09:52:51 +0530
Subject: [PATCH net-next] macb: Common code to enable ptp support for
 SAMA5Dx platforms.
In-Reply-To: <1c534b5a-25cb-a5d6-f87c-db9ed958a606@atmel.com>
References: <1484758673-8694-1-git-send-email-andrei.pistirica@microchip.com>
 <1c534b5a-25cb-a5d6-f87c-db9ed958a606@atmel.com>
Message-ID: <CAFcVEC+fVUZzsJBZtbzxYw70zp7vyzdQ+bC97jGN-x--1bmBUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 11:02 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 18/01/2017 ? 09:57, Andrei Pistirica a ?crit :
>> This patch does the following:
>> - add GEM-PTP interface
>> - registers and bitfields for TSU are named according to SAMA5Dx data sheet
>> - PTP support based on platform capability
>
> The $subject will certainly never match reality, sadly "enable ptp
> support for SAMA5Dx platforms". So, you'd better change it.
> (no "." at the end BTW).
>
>> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
>> ---
>> This is just the common code for GEM-PTP support. Code is based on the comments
>> related to the following patch series:
>> - [RFC PATCH net-next v1-to-4 1/2] macb: Add 1588 support in Cadence GEM.
>> - [RFC PATCH net-next v1-to-4 2/2] macb: Enable 1588 support in SAMA5Dx platforms.
>>
>> Note: Patch on net-next: January 18.
>>
>> Rafal/Harini, you can continue the work for GME-GXL.

Thanks Andrei.

<snip>
>
> Otherwise, I'm okay with the rest.
>
> I suggest to people that will keep the ball rolling on this topic to
> take advantage of the chunks of code that Andrei developed with the help
> of Richard and the best practices discussed. I think particularly, if it
> makes sense with HW, about:
> - gem_ptp_do_[rt]xstamp(bp, skb) dereference scheme
> - gem_ptp_adjfine() rationale
> - gem_get_ptp_peer() if needed
>

Sure, will patch on top of this.

Regards,
Harini

> Regards,
> --
> Nicolas Ferre
