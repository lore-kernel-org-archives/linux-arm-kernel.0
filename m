From: khilman@ti.com (Kevin Hilman)
Date: Mon, 10 Oct 2011 15:24:15 -0700
Subject: [PATCH v6 02/16] OMAP2+: hwmod: Add API to check IO PAD wakeup
	status
In-Reply-To: <CAAL8m4xkC1Ftnr=RpAK5m2PVvPx3yzitO5gNJfOKiD0_YkGkdA@mail.gmail.com>
	(Govindraj's message of "Mon, 3 Oct 2011 11:26:04 +0530")
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-2-git-send-email-govindraj.raja@ti.com>
	<4E8724D7.6060907@ti.com>
	<CAAL8m4zLz4kv+nNPKHD6zKG0pdXifXpmWiHnLAyn_bq228qHXA@mail.gmail.com>
	<4E8946BD.1010108@ti.com>
	<CAAL8m4xkC1Ftnr=RpAK5m2PVvPx3yzitO5gNJfOKiD0_YkGkdA@mail.gmail.com>
Message-ID: <878vosh4ds.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Mon, Oct 3, 2011 at 10:53 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> On Monday 03 October 2011 10:30 AM, Govindraj wrote:
>>
>>> On Sat, Oct 1, 2011 at 8:03 PM, Rajendra Nayak<rnayak@ti.com> ?wrote:
>>>>
>>>> On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
>>>>>
>>>>> Add API to determine IO-PAD wakeup event status for a given
>>>>> hwmod dynamic_mux pad.
>>>>>
>>>>> Wake up event set will be cleared on pad mux_read.
>>>>
>>>> Are these api's even getting used in this series?
>>>
>>> Used in Tero's irq_chaining patches.
>>
>> So shouldn't this patch be part of his series instead?
>
> Yes it is. Part of his v9-series.
>

Then please drop from this series and state the introductory patch
(PATCH 0/n) that this series has a dependency on Tero's series.

Kevin
