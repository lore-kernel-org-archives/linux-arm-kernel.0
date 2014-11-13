From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 13 Nov 2014 11:12:40 -0700
Subject: [PATCH 0/3] miscellaneous fixes in coresight
In-Reply-To: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
References: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CANLsYkyPnVJ75-TYYionMtd2KJzs29UK9LD3Fj4vk=Apvfh0Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2014 01:42, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> This patch series fixes some typo and minor issues in coresight which
> I observed while going through this driver.
>
> Pankaj Dubey (3):
>   coresight: fix typo in comment in coresight-priv.h
>   coresight: fixed comments in coresight.h
>   coresight-replicator: remove .owner field for driver
>
>  drivers/coresight/coresight-priv.h       |    2 +-
>  drivers/coresight/coresight-replicator.c |    1 -
>  include/linux/coresight.h                |    6 +++---
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> --
> 1.7.9.5
>

Applied all 3 patches - thanks
