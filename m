From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 9 Jul 2010 18:32:02 +0300
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <20100709151535.GA14644@oksana.dev.rtsoft.ru>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
	<201007091707.47807.anarsoul@gmail.com>
	<20100709151535.GA14644@oksana.dev.rtsoft.ru>
Message-ID: <201007091832.06871.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 9 ???? 2010 18:15:35 ????? Anton Vorontsov ???????:
> Still think this wont work?

Ok, one more question: pda_power requests irq with cleared TRIGGER flags, but 
I need TRIGGER_RISING | TRIGGER_FALLING, how can I add my custom irq flags to 
pda_power driver? :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100709/1d9bbe63/attachment.sig>
