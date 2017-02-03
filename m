From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 3 Feb 2017 17:35:42 +0530
Subject: [PATCH 1/6] mailbox: Add new API mbox_channel_device() for clients
In-Reply-To: <1486010836-25228-2-git-send-email-anup.patel@broadcom.com>
References: <1486010836-25228-1-git-send-email-anup.patel@broadcom.com>
 <1486010836-25228-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <CABb+yY1yKnFN-6=+xhZzcYrXNBe5eATthwOoHdvDrLmQzpEZ-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 10:17 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> The remote processor can have DMAENGINE capabilities and client
> can pass data to be processed via main memory. In such cases,
> the client will require DMAble memory for remote processor.
>
> This patch adds new API mbox_channel_device() which can be
> used by clients to get struct device pointer of underlying
> mailbox controller. This struct device pointer of mailbox
> controller can be used by clients to allocate DMAble memory
> for remote processor.
>
IIUC, DT already provides a way for what you need.
