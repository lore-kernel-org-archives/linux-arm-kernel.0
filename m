From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Mon, 22 Nov 2010 05:58:04 -0600
Subject: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <20101122115153.GE2446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
	<20101119083250.GH6446@legolas.emea.dhcp.ti.com>
	<AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
	<4CE68E9A.5040903@ti.com>
	<20101122100815.GM2446@legolas.emea.dhcp.ti.com>
	<AANLkTim4bHJHFdOEXt-hM7Yt2wGsVTcfJExwzzcUKXmq@mail.gmail.com>
	<20101122115153.GE2446@legolas.emea.dhcp.ti.com>
Message-ID: <AANLkTi=RegCd+VrhbPpmt-xC5RxetdzsGkAy5v-z=9fV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Mon, Nov 22, 2010 at 5:51 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 05:46:53AM -0600, Kanigeri, Hari wrote:
>>>
>>> From the dmtimer stuff, it looks like the driver defines the version
>>
>> types, which hwmod uses to define the rev field.
>>
>> /* timer ip constants */
>> #define OMAP_TIMER_IP_LEGACY ? ? ? ? ? ? ? ? ? ?0x1
>> #define OMAP_TIMER_IP_VERSION_2 ? ? ? ? ? ? ? ? 0x2
>
> in that case, it's the same as if you pass in a flag via platform_data.
> You might as well call it rev, then the diff when converting to hwmod
> will be smaller maybe :-p

I agree with you, the changes should be minimal converting to hwmod.


Thank you,
Best regards,
Hari Kanigeri
