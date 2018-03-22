From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Mar 2018 15:28:37 -0700
Subject: v4.16-rc5 on Motorola Droid 4
In-Reply-To: <20180322123518.GA27004@amd>
References: <20180322123518.GA27004@amd>
Message-ID: <20180322222837.GG5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180322 12:36]:
> What does _not_ yet work is battery charging, and I'm not sure if the
> phone will actually shut down itself or if it will drain & damage the
> battery.

Hmm you have IIO and CPCAP related options enabled, right?

Maybe define DEBUG in cpcap-charger.c, cpcap-battery.c
and cpcap-adc.c and see what output you get?

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/94e603a5/attachment.sig>
