From: davem@davemloft.net (David Miller)
Date: Fri, 01 Mar 2013 03:37:32 -0500 (EST)
Subject: [PATCH v2 1/1 net-next] fec: net: put tx to napi poll function
 to fix dead lock
In-Reply-To: <CANg6MZiQTPkWDBRiZB74nVrj-QY2=Nis36fvhv1Cj+p=jzOstA@mail.gmail.com>
References: <1362109034-25805-1-git-send-email-Frank.Li@freescale.com>
 <CANg6MZiQTPkWDBRiZB74nVrj-QY2=Nis36fvhv1Cj+p=jzOstA@mail.gmail.com>
Message-ID: <20130301.033732.2050436929173088609.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <linuxzsc@gmail.com>
Date: Fri, 1 Mar 2013 16:30:05 +0800

> Is it better to change title prefix to net: fec: ..... ?

I'm aiming to put it into 'net' regardless of what title prefix he
uses :-)
