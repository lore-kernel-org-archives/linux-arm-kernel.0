From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 15 Feb 2016 14:28:23 +0530
Subject: [PATCH v7 0/4] mailbox: hisilicon: add Hi6220 mailbox driver
In-Reply-To: <1454599500-15600-1-git-send-email-leo.yan@linaro.org>
References: <1454599500-15600-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CABb+yY2_4p6wu0qo0p8S3enD-EO=B4LXmC0569Z7tSj0zdjQHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 8:54 PM, Leo Yan <leo.yan@linaro.org> wrote:
> Hi6220 mailbox supports up to 32 channels. Each channel is unidirectional
> with a maximum message size of 8 words. I/O is performed using register
> access (there is no DMA) and the cell raises an interrupt when messages
> are received.
>
> This patch series is to implement Hi6220 mailbox driver. It registers
> two channels into framework for communication with MCU, one is tx channel
> and another is rx channel. Now mailbox driver is used to send message to
> MCU to control dynamic voltage and frequency scaling for CPU, GPU and DDR.
>
> Changes from v6:
> * Fix to use lowercase for hexadecimal value in DT binding document
>
Looks ok, but please rebase over mailbox-for-next and resend.

Thanks.
