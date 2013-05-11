From: chenlibo.3@gmail.com (Libo Chen)
Date: Sat, 11 May 2013 19:27:48 +0800
Subject: [PATCH] usb: gadget: s3c2410: fix clk resource leak and update
In-Reply-To: <1684189.YrZqmJjoym@flatron>
References: <518DE4FF.1000702@gmail.com> <1684189.YrZqmJjoym@flatron>
Message-ID: <518E2B34.7080503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013-5-11 18:15, Tomasz Figa ??:
> Hi Libo,
>
> On Saturday 11 of May 2013 14:28:15 Libo Chen wrote:
>> >From: Libo Chen<libo.chen@huawei.com>
> The patch subject is slightly misleading. It suggests that the patch only
> changes clock handling, but in fact the biggest part of the patch is
> conversion to devm_ helpers.
>
> I think following subject would suit this patch better:
>
> [PATCH] usb: gadget: s3c2410: Convert to managed resource allocation
>
> What do you think?
>
> Also please see my comments inline.
>

Hi Tomasz,

Thank you for your remind. Sorry, I forgeted to add RFC.

"Convert to managed resource allocation" is more suitable.

Your advice is very helpfull for me to understand those interfaces.
I will be careful in the future patches.

Thanks again
