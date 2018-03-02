From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Mar 2018 13:37:37 +0100
Subject: [PATCH 0/4] drm/pl111: RealView and Versatile Express
In-Reply-To: <6b215e16-5245-7550-f1cb-a0f41d4a3178@arm.com>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
 <6b215e16-5245-7550-f1cb-a0f41d4a3178@arm.com>
Message-ID: <CACRpkdaVXrT24XvzJ4ciqEp8NRXFNG+e0VkM_JtgGBdpKa8P8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 1:11 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 02/03/18 09:09, Linus Walleij wrote:

>> Also the Versatile Express CLCD on the motherboard has
>> a dedicated video memory, and cannot use CMA (ha! complex!)
>> and I will need to figure out a way to work around that.
>> The CLCDs synthesized on the core tiles for CA9 work
>> fine with this though.
>
> Out of curiosity, what's the issue with declaring the VRAM as a CMA region?
> That's certainly worked for stuff like local RAM on FPGA tiles in the past,
> and I can't think offhand of any way in which VExpress is wildly different
> (but I am of course open to being wrong...)

There is nothing wrong with that apart from my ignorance
of that solution. So thanks! :D

My experience with CMA is limited to using the 7 areas
that are defined by default in Kconfig and the DRM helpers
just plugging in on the front.

Do you have some pointers? Is this something I can
handily just set up in the device tree?

Yours,
Linus Walleij
