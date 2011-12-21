From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Dec 2011 16:07:00 -0200
Subject: [PATCH] arm: device.h: Add dma_mask to pdev_archdata structure
In-Reply-To: <CAOMZO5BOYRKz9uVrhe43q9SxGdyELPGktWVNks=vcXb2MZnYAA@mail.gmail.com>
References: <1321415178-12179-1-git-send-email-festevam@gmail.com>
 <4EF0359C.1090703@googlemail.com>
 <CAOMZO5BOYRKz9uVrhe43q9SxGdyELPGktWVNks=vcXb2MZnYAA@mail.gmail.com>
Message-ID: <CAOMZO5A3ufSZPvxTgmPiHRJnV70oxhb9VmYP+ECBgyZhah6uDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 3:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Dirk,
>
> On Tue, Dec 20, 2011 at 5:13 AM, Dirk Behme <dirk.behme@googlemail.com> wrote:
>
>> Will there ?be a v2 of this patch fixing the review comments?
>>
>> It seems the number of people hit by the issue this patch deals with
>> increases ...
>
> I no longer see this issue on a recent kernel.
>
> drivers/usb/host/fsl-mph-dr-of.c is not built for i.MX now.
>
> If you still see this issue, let me know how to reproduce it.

Ok, I managed to reproduce it and will submit a patch to the USB mailig list.

Regards,

Fabio Estevam
