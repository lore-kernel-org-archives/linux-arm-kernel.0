From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 29 Aug 2016 15:30:18 -0700
Subject: [PATCH 3/5] firmware: ti_sci: Add support for Device control
In-Reply-To: <CAGo_u6p3Bm+zGDtxpOyT+DeGN8_XPWWE0zhCYuxsH47n41Z8jg@mail.gmail.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-4-nm@ti.com>
 <9a6a8663-a3f7-7875-253f-98232d56b860@ti.com>
 <CAGo_u6p3Bm+zGDtxpOyT+DeGN8_XPWWE0zhCYuxsH47n41Z8jg@mail.gmail.com>
Message-ID: <e936ee55-34ec-dbc6-5ba0-7fe9c54013cc@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishant,

On 8/23/2016 11:45 AM, Nishanth Menon wrote:
> On Sun, Aug 21, 2016 at 10:56 PM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>>  /**
>>> + * tis_sci_is_response_ack() - Generic ACK/NACK message checkup
>>> + * @r:       pointer to response buffer
>>> + *
>>> + * Return: true if the response was an ACK, else returns false.
>>> + */
>>> +static inline bool tis_sci_is_response_ack(void *r)
>>
>> May be just ti_sci_is_response_ack() to be consistent? or you wanted to
>> keep it tis_sci* ?
>
>
> Uggh.. Fat fingered that one.. thanks for catching.. fixed and will
> post a v2 next week if there is no further comments
>
I would like to send the next merge window queue up so please repost
the reviewed patches which needs to be queued up.

Regards,
Santosh
