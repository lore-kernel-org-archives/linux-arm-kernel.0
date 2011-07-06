From: padma.kvr@gmail.com (padma venkat)
Date: Wed, 6 Jul 2011 12:34:52 +0530
Subject: [PATCH 1/2] SPI: S5PC100: Enable the SPI driver for S5PC100
In-Reply-To: <20110705100506.GT8286@n2100.arm.linux.org.uk>
References: <1309801476-29678-1-git-send-email-padma.v@samsung.com>
	<20110705100506.GT8286@n2100.arm.linux.org.uk>
Message-ID: <CAAgF-BdGHzTjQABzqzVN=-XA6Qzn3b0FPppZLY_XG3OMehYwcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jul 5, 2011 at 3:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 04, 2011 at 01:44:35PM -0400, Padmavathi Venna wrote:
>> ?config SPI_S3C64XX
>> ? ? ? tristate "Samsung S3C64XX series type SPI"
>> - ? ? depends on (ARCH_S3C64XX || ARCH_S5P64X0)
>> + ? ? depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_S5PC100)
>
> Just get rid of the unnecessary parens here.
Thanks for your comment. I will remake the patch and will send the same.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
