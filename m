From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 12 Aug 2016 21:12:07 +0530
Subject: [PATCH 6/8] drivers: platform: Remove call to
 of_dma_(con/decon)figure_ops
In-Reply-To: <CAAFQd5DZ0ZpW2eEm8Bvh8=di6kOgUG4bGY_iTNbVBHsj0KPmeg@mail.gmail.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-7-git-send-email-sricharan@codeaurora.org>
 <CAAFQd5DZ0ZpW2eEm8Bvh8=di6kOgUG4bGY_iTNbVBHsj0KPmeg@mail.gmail.com>
Message-ID: <000b01d1f4b0$180b7300$48225900$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomaz,

>> The dma_ops gets configured for the device generically during
>> the device_attach call. So remove it from the platform bus probe.
>> Similarly remove the deconfigure calls as well, since it is
>> now called form the device_detach path.
>
>Doesn't this patch need to be squashed with previous one to avoid
>breaking things in between by having the of_dma_configure_ops() called
>two times?
>
  okay, i did it this way, for the sake of review. But ya will squash
  it for the next post.

Regards,
 Sricharan
