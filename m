From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Tue, 19 Feb 2013 19:47:49 +0100
Subject: coda: support of decoding
In-Reply-To: <5122D999.3070405@gmail.com>
References: <5122D999.3070405@gmail.com>
Message-ID: <20130219184749.GD30071@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 02:47:05AM +0100, Ga?tan Carlier wrote:
> I see in code source of coda driver that decoding is not supported.
>
> ctx->inst_type = CODA_INST_DECODER;
> v4l2_err(v4l2_dev, "decoding not supported.\n");
> return -EINVAL;
>
> Is there any technical reason or the code has not been written ?

We have a lot of encoder + decoder patches for Coda in the queue, but
unfortunately not all of that is ready-for-primetime yet.

Which processor are you interested in? MX27 or MX5/MX6?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
