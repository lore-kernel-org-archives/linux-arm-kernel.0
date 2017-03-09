From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 9 Mar 2017 12:00:01 +0100
Subject: [PATCH 00/10] ARM: davinci: add vpif display support
In-Reply-To: <77ced65d-e350-02ba-6dae-b20dcb3faa32@xs4all.nl>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <77ced65d-e350-02ba-6dae-b20dcb3faa32@xs4all.nl>
Message-ID: <CAMpxmJUZ3KCV2zjpPWD02rVpok_XV-fGdk8PNpN7FGt3RDbMEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-09 11:53 GMT+01:00 Hans Verkuil <hverkuil@xs4all.nl>:
> On 07/02/17 17:41, Bartosz Golaszewski wrote:
>> The following series adds support for v4l2 display on da850-evm with
>> a UI board in device tree boot mode.
>
> As far as I could tell from the comments this patch series will see a
> second version, so I am marking it as 'Changes Requested' in patchwork.
>
> If I'm wrong, then please let me know.
>
> Regards,
>
>         Hans
>

Hi Hans,

this series has since been split into several smaller ones and most of
the code is already merged into Sekhar Nori's DaVinci tree.

There are two series that still need merging with the media tree[1][2].

Thanks,
Bartosz Golaszewski

[1] https://lkml.org/lkml/2017/2/28/426
[2] https://patchwork.kernel.org/patch/9577965/
