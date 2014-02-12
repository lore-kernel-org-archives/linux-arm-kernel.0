From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Wed, 12 Feb 2014 13:36:08 +0100
Subject: [PATCH v4 0/8] Device Tree support for the at91sam9261ek
In-Reply-To: <20140212133449.5c42216d@skate>
References: <1392199607-27452-1-git-send-email-jjhiblot@traphandler.com>
 <52FB5795.9020708@free-electrons.com>
 <20140212133449.5c42216d@skate>
Message-ID: <CACh+v5Nv7u4WSXttvsnMPxwNwN6R4ZDRABOXr9XXBjy6mSDi5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


2014-02-12 13:34 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Gregory CLEMENT,
>
> On Wed, 12 Feb 2014 12:14:29 +0100, Gregory CLEMENT wrote:
>
>> For dm9000 the issue is (again) related to an ordering problem:
>> the Ethernet need an interrupt provided by the gpio driver. Unfortunately,
>> the gpio driver initialization is called after the dm900 driver
>> initialization.
>
> And -EPROBE_DEFER doesn't solve this problem?
not really the problem happens before the driver is actually probed
when the ressource for the platform driver are filled
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
