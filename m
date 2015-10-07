From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Oct 2015 11:42:07 -0300
Subject: imx serial driver commit breaks system boot on i.MX6 boards
In-Reply-To: <20151007143904.GA11573@pqgruber.com>
References: <20151007143904.GA11573@pqgruber.com>
Message-ID: <CAOMZO5CDC8swE6HwjiA97=mZaXnGsHCwrj9MjP7SAd3EJKv-Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2015 at 11:39 AM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> A revert patch from Fabio Estevam was sent on Aug 18th of 2015.
>
> Is there a reason why that revert patch has not been merged yet?
> Hopefully this will be fixed before the 4.3 release.

Already reverted in Greg's tree:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=0c727a42043f79db210cdde0366f9137b9c6bf5a

Should be available in 4.3-rc5.
