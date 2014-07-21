From: stwiss.opensource@diasemi.com (Opensource [Steve Twiss])
Date: Mon, 21 Jul 2014 14:40:02 +0000
Subject: [RFC V2] devicetree: Dialog Semiconductor consolidate existing
 vendor prefixes to standardise on 'dlg'
In-Reply-To: <201407151520.s6FFKcjB009745@swsrvapps-01.diasemi.com>
References: <201407151520.s6FFKcjB009745@swsrvapps-01.diasemi.com>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B274CB@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15 July 2014 16:04, Steve Twiss wrote:

>From: Opensource [Steve Twiss] [mailto:stwiss.opensource at diasemi.com]
>Sent: 15 July 2014 16:04
>Subject: [RFC V2] devicetree: Dialog Semiconductor consolidate existing vendor
>prefixes to standardise on 'dlg'
[...]
>This patch series updates the device tree vendor prefix for
>Dialog Semiconductor.
>Various methods are currently used throughout the kernel: 'diasemi',
>'dialog' and 'dlg'. Others have also been suggested.
>This patch set aims to consolidate the usage of the vendor prefix to
>use a common standard. The prefix 'dlg' is used.
[...]

Hello all,

Have there been any further thoughts on this? I would like move this issue forwards so
that this problem this does not keep arising.

>From my point of view, the argument is a simple one: what is the value of existing multiple
vendor prefixes if they do not work and are not used anywhere?

But, as usual I recognise that the kernel community have different aims and I am willing
to compromise with my patches in order to move ahead.

Regards,
Steve
