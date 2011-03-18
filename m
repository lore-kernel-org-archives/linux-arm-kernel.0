From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Mar 2011 09:26:23 +0100
Subject: [PATCH 3/3] mach-ux500: configure board for the TPS61052
	regulator v2
In-Reply-To: <20110317234241.GB32168@sortiz-mobl>
References: <1299672196-4778-1-git-send-email-linus.walleij@stericsson.com>
	<20110317234241.GB32168@sortiz-mobl>
Message-ID: <AANLkTinT_fcTJ=gJUDAFW=qjdYbxdOCdoUq=PCFgzvo3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 12:42 AM, Samuel Ortiz <samuel.ortiz@intel.com> wrote:
> On Wed, Mar 09, 2011 at 12:03:16PM +0000, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This registers the TPS61052 regulator to the ux500 MOP/HREF boards.
>
> Patch applied as well.

Oh no please skip that patch for now.

It will just collide with Russell's tree in -next and wreak havoc.

I will take that platform data in the next merge window or through
Torvalds' tree after Russells and yours is merged, safest path.

Linus Walleij
