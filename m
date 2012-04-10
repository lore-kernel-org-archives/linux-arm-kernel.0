From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 11 Apr 2012 06:08:28 +0900
Subject: [PATCH 3/4] arm: davinci: use for_each_set_bit_from
In-Reply-To: <4F8462DE.4030004@ti.com>
References: <1333442836-9947-1-git-send-email-akinobu.mita@gmail.com>
 <1333442836-9947-3-git-send-email-akinobu.mita@gmail.com>
 <4F8462DE.4030004@ti.com>
Message-ID: <CAC5umygW+i=8=a+x7BnDuN=GPBFSXA4TWgrvQQvtWv0jSreWXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/4/11 Sekhar Nori <nsekhar@ti.com>:
> Hi Akinobu,
>
> On 4/3/2012 2:17 PM, Akinobu Mita wrote:
>> Use for_each_set_bit_from to iterate over all the set bit in a memory
>> region.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-arm-kernel at lists.infradead.org
>
> Looks good to me. If you are planning to send this upstream outside of
> davinci tree, please add my:
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
> Else, let me know and I will be happy to queue it.

Christian found a bug in this patch. So  I'll resend it, then please queue it
to your tree.
