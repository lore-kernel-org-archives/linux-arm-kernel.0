From: adrian.wenl@gmail.com (Lei Wen)
Date: Thu, 3 Mar 2011 11:00:35 +0800
Subject: [PATCH V5 1/6] pxa3xx_nand: make scan procedure more clear
In-Reply-To: <1298901359.2809.25.camel@localhost>
References: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
	<1298860335-18638-2-git-send-email-leiwen@marvell.com>
	<1298901359.2809.25.camel@localhost>
Message-ID: <AANLkTinb7oZDzvD94RWLZqnLnaX5kY97CxJ+34eVJNmU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On Mon, Feb 28, 2011 at 9:55 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Mon, 2011-02-28 at 10:32 +0800, Lei Wen wrote:
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>
> Could you please improve the commit message and make it explain why your
> code makes "scan" more clear, what exactly you do to improve it?
>

The previous probe function is some kind of big part. I seperate the resource
allocation in this patch to keep the probe process more clear than before.

It indeed, the original patch has little comments on it. I would post
a fixed version for that. :)

Thanks,
Lei
