From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 02 Jul 2012 17:21:08 +0530
Subject: [PATCH v2 05/17] i2c: omap: split out [XR]DR and [XR]RDY
In-Reply-To: <20120702113314.GA2730@arwen.pp.htv.fi>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
 <1339691067-919-6-git-send-email-balbi@ti.com> <4FE991DA.5070301@ti.com>
 <20120702113314.GA2730@arwen.pp.htv.fi>
Message-ID: <4FF18B2C.8080102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012 05:03 PM, Felipe Balbi wrote:
>>> +				num_bytes = dev->fifo_size;
>> > In case of a draining interrupt. The byte count may not be the fifo size.
>> > Do you agree?
> hmm... indeed, that should be dev->buf_len... can you fix that up or
> want me to resend ?
Nope I can fix that up.
Thanks,
