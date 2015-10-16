From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 16 Oct 2015 10:43:00 +0530
Subject: [PATCH v4 2/4] mailbox: Hi6220: add mailbox driver
In-Reply-To: <1444667535-16948-3-git-send-email-leo.yan@linaro.org>
References: <1444667535-16948-1-git-send-email-leo.yan@linaro.org>
 <1444667535-16948-3-git-send-email-leo.yan@linaro.org>
Message-ID: <CABb+yY2uJZFgDeviRzz8ghVhNzy5d6jf+=fpTAUez01m+O0ttw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 10:02 PM, Leo Yan <leo.yan@linaro.org> wrote:

> +
> +#define MBOX_CHAN_MAX                  32
> +#define MBOX_CHAN_NUM                  2
> +
You mean the hardware has 32 channels but this driver can not manage
more than 2 ?

OR, there are 32 interfaces but only 2 physical 'floating' links, so
no more than 2 interfaces can be active at any time?
