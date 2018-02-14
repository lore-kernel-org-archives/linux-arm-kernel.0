From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Feb 2018 14:39:35 +0100
Subject: [PATCH v2 0/3] gpio-keys: Add support for specifying wakeup event
 action
In-Reply-To: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
Message-ID: <1541427.8RRpDbxO4f@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Am Samstag, 10. Februar 2018, 12:09:04 CET schrieb Jeffy Chen:
> On chromebook kevin, we are using gpio-keys for pen insert event. But
> we only want it to wakeup the system when ejecting the pen.
> 
> So we may need to change the interrupt trigger type during suspending.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
> Jeffy Chen (3):
>   Input: gpio-keys - add support for wakeup event action
>   Input: gpio-keys - allow setting wakeup event action in DT
>   arm64: dts: rockchip: Avoid wakeup when inserting the pen

The recipient-selection for the mail thread seems to be a bit off and
I only got the cover-letter and patch 3/3.
Therefore I won't really see if and when the Input-changes get
accepted. So please ping me once that has happened so I can pick up
the rockchip dts change for it.


Thanks
Heiko
