From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 18 Feb 2012 10:01:45 +0530
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <1329508513.1858.15.camel@dave-Dell-System-XPS-L502X>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CAMQu2gwfo5JXAqQaLUNs7C7J3TUhEO2zOcyD0Rk-D_O61Yrfag@mail.gmail.com>
 <CAMsRxfLNBbQO5XF+EHJqNsnW+s=ay3mjSV5dh=sxdwzktUu03g@mail.gmail.com>
 <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <1329508513.1858.15.camel@dave-Dell-System-XPS-L502X>
Message-ID: <CAMQu2gw14=hrOqudWf9GU8tpvjSLj-XjiWDzPaXMBD_x48-BZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 18, 2012 at 1:25 AM, David Long <dave.long@linaro.org> wrote:
> Hi Santosh,
>
> Have you determined yet whether or not the l4_wkup change we tested for you
> (and found to improve the 32k timer reliability), is something that should
> be made permanent?
>
The issue is confirmed with synctime idle. I am just waiting on for the
right work around confirmation from hardware team. As soon as
I have that, will post a patch.

Regards
Santosh
