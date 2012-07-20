From: alchark@gmail.com (Alexey Charkov)
Date: Fri, 20 Jul 2012 17:24:37 +0200
Subject: [PATCH] ARM: vt8500: Minor updates to platform drivers for
 devicetree support
In-Reply-To: <1342795183-7942-1-git-send-email-linux@prisktech.co.nz>
References: <1342795183-7942-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CABjd4YwmtyiSU9x=jTLCjR7S67qeDQjrCRbXJydX9gGsj-ctMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/20 Tony Prisk <linux@prisktech.co.nz>:
> Updated the vt8500-rtc and vt8500-uart platform drivers for
> devicetree support.

Shouldn't these go as separate patches? Note also that you haven't
CC'd the relevant mailing lists on this one.

> diff --git a/Documentation/devicetree/bindings/rtc/vt8500-rtc.txt b/Documentation/devicetree/bindings/rtc/vt8500-rtc.txt
> new file mode 100644
> index 0000000..8cf6ce1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/vt8500-rtc.txt
> @@ -0,0 +1,14 @@
> +* SPEAr RTC

Looks like a copy-paste leftover.

Thanks,
Alexey
