From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Sep 2009 20:33:02 +0100
Subject: [AT91] Fix AC97 breakage
In-Reply-To: <cd73a99e0909220247i71a2084fu9153002a358be1f1@mail.gmail.com>
References: <cd73a99e0909220247i71a2084fu9153002a358be1f1@mail.gmail.com>
Message-ID: <20090922193302.GA2616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2009 at 11:47:43AM +0200, Andrew Victor wrote:
> Fix AC97 build breakage with converting to the shared AT91/AVR32 AC97 driver:
>   struct atmel_ac97_data  -> struct ac97c_platform_data
>   CONFIG_SND_AT91_AC97 -> CONFIG_SND_ATMEL_AC97C
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>

If this has been build-tested, please submit it to the patch system.
