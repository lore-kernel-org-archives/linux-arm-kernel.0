From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 21 Jul 2014 11:40:07 -0700
Subject: [PATCH] platform: Make platform_bus device a platform device
In-Reply-To: <1405962034-25482-1-git-send-email-pawel.moll@arm.com>
References: <CAOesGMgvd1HbjywN7BDPtr8ZU7vucWH48B=AW3TZjng73YA8WA@mail.gmail.com>
 <1405962034-25482-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140721184007.GB572@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 06:00:34PM +0100, Pawel Moll wrote:
> ... describing the root of the device tree, so one can write
> a platform driver initializing the platform.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> 
> For what it's worth, the patch I came up back then.
> *Untested* against current head...

I like the idea, nice...
