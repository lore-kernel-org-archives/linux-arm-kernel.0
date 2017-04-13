From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Apr 2017 19:00:16 -0300
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <CANMBJr4mci5LyuBNT50dupxSVz+t-5mhWv8a7LBvY4MgupomVQ@mail.gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
 <CAOMZO5CgLP7P+Q2Mvzpnx6u5ryb1TjAvaj9xDKXpD+8fMmn7MQ@mail.gmail.com>
 <CANMBJr4BWtU7SXEa0-4LFLx+ydVWas0Cx18kRn-=-Bz8pPZ=fg@mail.gmail.com>
 <CAOMZO5BaKBsXean8-560HUuZbhjef9dpMNku0SRUVtkv+XsZ6w@mail.gmail.com>
 <CANMBJr7We9uOyE6=BCWoe9L7xRKjOG6ScgtDGEgQ-hPawPeppg@mail.gmail.com>
 <CAOMZO5BjzSJws7zjJ5+aZkfeF+15twEu9zS3V+g6wQrtUiNyqQ@mail.gmail.com>
 <CANMBJr4mci5LyuBNT50dupxSVz+t-5mhWv8a7LBvY4MgupomVQ@mail.gmail.com>
Message-ID: <CAOMZO5CdmpXXu0ZQ0VQFkhyTPtiK36mN5FajzSNi5t3oqedEYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 6:35 PM, Tyler Baker <tyler.baker@linaro.org> wrote:

> The following patch fixes the backtrace on my board. I'll submit this
> patch in a moment.
>
> From: Tyler Baker <tyler.baker@linaro.org>
> Date: Thu, 13 Apr 2017 14:29:49 -0700
> Subject: [PATCH] irqchip/irq-imx-gpcv2: fix spinlock initialization
>
> Call raw_spin_lock_init() before the spinlocks are used to prevent a
> lockdep splat.
>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>

Yes, it makes sense:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
