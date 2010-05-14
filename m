From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 14 May 2010 09:58:01 +0900
Subject: RMK closing tree to patches *this* weekend
In-Reply-To: <20100513230201.GA26822@n2100.arm.linux.org.uk>
References: <20100513230201.GA26822@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikMkO7wC5bmwZUHVX3_yPRkZCcOc8NyGp1zU_4i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 8:02 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> As of the end of this coming weekend, I'll stop taking patches for the
> next merge window. ?I want to tidy up the lose ends which need sorting
> out and give it a decent outing in linux-next for about a week before
> the merge window opens.
>
> So if there's any patches I've missed, please follow up to this email.
Hi Russell,

Would it be possible for you to merge the PL330 core driver in your tree?
If so, I would make sure the platform specific stuff get up via Ben Dooks'
tree in time.

Getting PL330 DMAC support is really important for latest Samsung SoCs
i.e, S5PV210, S5P6442, S5P6440 and S5PC100
that have Audio and SPI not working mostly due to lack of DMA support.

Thanks.
