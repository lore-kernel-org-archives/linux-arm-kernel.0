From: sjg@chromium.org (Simon Glass)
Date: Thu, 29 Nov 2012 18:13:01 -0800
Subject: [PATCH 2/2] i2c-s3c2410: Add bus arbitration implementation
In-Reply-To: <20121129163448.GA3761@sirena.org.uk>
References: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
 <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
 <20121129163448.GA3761@sirena.org.uk>
Message-ID: <CAPnjgZ0atD3k=gT0vjgkLO_SA8DMak6SiT6nZ_2T6WFqtK0szQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Olof

On Thu, Nov 29, 2012 at 8:34 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 29, 2012 at 10:35:35AM +0530, Naveen Krishna Chatradhi wrote:
>
>> The arbitrator is a general purpose function which uses two GPIOs to
>> communicate with another device to claim/release a bus. We use it to
>> arbitrate an i2c port between the AP and the EC.
>
> Should this not be layerd on top of the I2C controller rather than part
> of the controller driver?  It doesn't seem terribly controller specific.

It was originally done separately but I think it was felt that this
was overly complex. Olof can you please comment on this?

Regards,
Simon
