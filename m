From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 9 Jul 2010 18:32:43 +0300
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <201007091832.06871.anarsoul@gmail.com>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
	<20100709151535.GA14644@oksana.dev.rtsoft.ru>
	<201007091832.06871.anarsoul@gmail.com>
Message-ID: <201007091832.47776.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 9 ???? 2010 18:32:02 ????? Vasily Khoruzhick ???????:
> Ok, one more question: pda_power requests irq with cleared TRIGGER flags,
> but I need TRIGGER_RISING | TRIGGER_FALLING, how can I add my custom irq
> flags to pda_power driver? :)

Oops, sorry, they aren't cleared :) Sorry for the noise
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100709/130da2b9/attachment.sig>
