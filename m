From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 27 Sep 2012 09:13:13 +0200
Subject: [PATCH 2/6] spi: atmel: add dmaengine and dt support
In-Reply-To: <20120926070511.GI21730@pengutronix.de>
References: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
 <1348642261-27554-3-git-send-email-wenyou.yang@atmel.com>
 <20120926070511.GI21730@pengutronix.de>
Message-ID: <CACQ1gAi_e2nJNQv6TP1_F8b9ZHa9=F34gCB4nK7mH0Gvk0JhuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2012/9/26 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Wed, Sep 26, 2012 at 02:50:57PM +0800, Wenyou Yang wrote:
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> I don't remember ever having touched the spi-atmel driver, so I'm pretty
> sure I never gave my S-o-b for anything in this patch. Please reread
> Documentation/SubmittingPatches and double check you understood what
> Signed-off-by means before resubmitting this patch with all wrong
> S-o-b's removed.

By the way, what is the correct way to send a patch based on other's work ?
If I believe Documentation/SubmittingPatches, only the sender should
add his S-o-b.
But if you want to give credit to the original author(s), what's the best way ?
IMHO, I would CC them, let them add their
s-o-b/ack-b/nack-b/whatever-b if they want, and maybe add something
like that in the file header :
/*
 * based on the original work of ...
 */
Or in the commit message itself
Is that right ?
