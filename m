From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 22 Aug 2016 15:38:09 +0200
Subject: [PATCH v2 0/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
In-Reply-To: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAPDyKFrF77Jx2bHbWRRSf9nsakXedsM3mJ8oxUHxZoa4R76_PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 July 2016 at 16:25, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Ulf, Maxime and Chen-Yu,
>
> Here is v2 of my patch set to deal with sun4i / sun5i not having
> mmc sample clocks, this time introducing a new sun7i-a20-mmc
> compatible for the models which do have sample clks, as discussed
> in the review of v1 of this set.
>
> Ulf, can you please add patches 1-4 to your tree for 4.9, and
> Maxime can you please pick up patch 5 ?
>
> Thanks & Regards,
>
> Hans

Thanks, applied for next!

Note that I picked the v2 of patch 5/5 and not the v3.

Kind regards
Uffe
