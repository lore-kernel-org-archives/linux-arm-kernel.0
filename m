From: gbean@codeaurora.org (Gregory Bean)
Date: Fri, 03 Sep 2010 08:44:26 -0700
Subject: Keyboard for HTC-Dream
In-Reply-To: <201009031701.34609.david.lanzendoerfer@o2s.ch>
References: <201008071307.40988.david.lanzendoerfer@o2s.ch>
	<20100816055540.GA1455@ucw.cz>
	<201009031701.34609.david.lanzendoerfer@o2s.ch>
Message-ID: <4C8117DA.8070605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [   24.870000] setting trigger mode 3 for irq 84 failed (msm_gpio_irq_set_type+0x0/0x118)

You're using an older submission of gpiolib which doesn't support 
dual-edge IRQs.  That one has been scrapped in favor of the one from 
android's 2.6.35-wip branch. It hasn't been accepted yet, and is 
currently being discussed on the mailing lists.  If you search the 
mailing list archives from the past two weeks you'll find the patches.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
