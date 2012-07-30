From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 30 Jul 2012 09:20:19 +0200
Subject: [PATCH 20/25] gpio/gpio-omap: make platformdata used as
 *of_device_id.data const
In-Reply-To: <20120730071736.GH1528@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-21-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAMQu2gw0fRa4kc2x-cm5ESGbo0tH30DnazaspHCnt6d9VjE9zg@mail.gmail.com>
 <20120730071736.GH1528@pengutronix.de>
Message-ID: <CAMQu2gyHsz+x09+2dLArP346g+2JmhYs+34pQKMEO8fvduhHXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 9:17 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sun, Jul 29, 2012 at 11:27:57PM +0200, Shilimkar, Santosh wrote:
>> On Mon, Jul 23, 2012 at 11:13 AM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> > ---
>> A line of description at least in the change log would be good otherwise
>> patch is fine to me. Thanks.
> I added:
>
>         Since of_device_id.data is declared as a pointer to const data a
>         few more consts can be added in this driver.
>
ok.

>> Acked-by: Santosh.shilimkar<santosh.shilimkar@ti.com>
> I assume your real name is "Santosh Shilimkar" and not
> "Santosh.shilimkar", isn't it?
>
Yes :-)
Thanks for correcting it.

Regards
Santosh
