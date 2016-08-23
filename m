From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Aug 2016 13:45:05 -0500
Subject: [PATCH 3/5] firmware: ti_sci: Add support for Device control
In-Reply-To: <9a6a8663-a3f7-7875-253f-98232d56b860@ti.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-4-nm@ti.com>
 <9a6a8663-a3f7-7875-253f-98232d56b860@ti.com>
Message-ID: <CAGo_u6p3Bm+zGDtxpOyT+DeGN8_XPWWE0zhCYuxsH47n41Z8jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 10:56 PM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>  /**
>> + * tis_sci_is_response_ack() - Generic ACK/NACK message checkup
>> + * @r:       pointer to response buffer
>> + *
>> + * Return: true if the response was an ACK, else returns false.
>> + */
>> +static inline bool tis_sci_is_response_ack(void *r)
>
> May be just ti_sci_is_response_ack() to be consistent? or you wanted to
> keep it tis_sci* ?


Uggh.. Fat fingered that one.. thanks for catching.. fixed and will
post a v2 next week if there is no further comments

---
Regards,
Nishanth Menon
