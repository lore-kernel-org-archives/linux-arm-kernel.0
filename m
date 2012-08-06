From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Aug 2012 11:26:52 -0300
Subject: [PATCH 1/1] mx27_3ds: Add sound support
In-Reply-To: <501FD389.1050105@gmail.com>
References: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
 <CAOMZO5B9ZmTHrYjVc5a7j=uUgUEyfDva54cKxBP3UeCYZsUWRw@mail.gmail.com>
 <501FD389.1050105@gmail.com>
Message-ID: <CAOMZO5B3i9NeSD-uqbjN6LLCR1UUhSYKs8g+D6yj7hs31kNJ6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 11:24 AM, Ga?tan Carlier <gcembed@gmail.com> wrote:
> Hi Fabio,
> Sorry, I have missed your patch in my email archive. I didn't search the
> right keywords.
> I applied your [patch 1/2] (2/2 is already merged) but I have same effect. I
> use aplay with file k3b_error1.wav (Unsigned 8 bit, Rate 8000 Hz, Mono) and
> alsa/Front_Left.wav (Signed 16 bit Little Endian, Rate 48000 Hz, Mono). Two
> sounds are played too fast.
> It is maybe a bad configuration of Alsa (but this is working with kernel
> 2.6.22 from Freescale).

Ok, we will need to debug this problem then.

Can you please send me offline these two files?

Regards,

Fabio Estevam
