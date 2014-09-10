From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 10 Sep 2014 08:22:32 -0500
Subject: [Patch v2 net-next 09/12] net: fec: change FEC alignment
 according to i.mx6 sx requirement
In-Reply-To: <CAOMZO5AwOWr8uWCvt3XzM8CJideu+1LBY6QUQ772QjLjCYxL1w@mail.gmail.com>
References: <1410293743-27874-1-git-send-email-Frank.Li@freescale.com>
 <1410293743-27874-10-git-send-email-Frank.Li@freescale.com>
 <CAOMZO5AwOWr8uWCvt3XzM8CJideu+1LBY6QUQ772QjLjCYxL1w@mail.gmail.com>
Message-ID: <CAHrpEqSf8j7NUZDAORYwN4cbd2MBA9bcKa9mzNGg4JJiKsJKvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 7:51 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Sep 9, 2014 at 5:15 PM, Frank Li <Frank.Li@freescale.com> wrote:
>
>> +       fep->rx_align = 0x3;
>> +       fep->tx_align = 0x3;
>
> Why do you unconditionally set it as 0x3? It was 0xf for ARM and 0x3
> for non-ARM.

Will fix it at next version.
