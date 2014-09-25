From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Sep 2014 09:51:35 +0200
Subject: [PATCH] gpio: only enable kona driver on BCM_MOBILE or for
 compile testing
In-Reply-To: <20140924080625.GE3755@pengutronix.de>
References: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdZg5uoP5LurL5vOPCaKQu2B=neybuo=gwM_JT7UAhRkjg@mail.gmail.com>
 <530FB808.5050802@broadcom.com>
 <20140924080625.GE3755@pengutronix.de>
Message-ID: <CACRpkdarku3XYSJ+-cUmd-FdK8sqd6=XBC6NJ9RL4V4hHh0vmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:06 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Feb 27, 2014 at 02:11:20PM -0800, Markus Mayer wrote:
>> On 14-02-27 01:16 AM, Linus Walleij wrote:
>> >On Fri, Feb 21, 2014 at 2:42 PM, Uwe Kleine-K?nig
>> ><u.kleine-koenig@pengutronix.de> wrote:
>> >
>> >>This change makes it easier to configure a kernel for a real machine by
>> >>not showing the option to enable it at all if COMPILE_TEST is off.
>> >>
>> >>Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> >
>> >Markus: can you ACK this patch?
>>
>> Acked-by: Markus Mayer <mmayer@broadcom.com>
> ping!

Patch applied with Markus' ACK!

Yours,
Linus Walleij
