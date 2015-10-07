From: clemens.gruber@pqgruber.com (Clemens Gruber)
Date: Wed, 7 Oct 2015 17:03:24 +0200
Subject: imx serial driver commit breaks system boot on i.MX6 boards
In-Reply-To: <CAOMZO5CDC8swE6HwjiA97=mZaXnGsHCwrj9MjP7SAd3EJKv-Jw@mail.gmail.com>
References: <20151007143904.GA11573@pqgruber.com>
 <CAOMZO5CDC8swE6HwjiA97=mZaXnGsHCwrj9MjP7SAd3EJKv-Jw@mail.gmail.com>
Message-ID: <20151007150323.GB11573@pqgruber.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 11:42:07AM -0300, Fabio Estevam wrote:
> On Wed, Oct 7, 2015 at 11:39 AM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> 
> > A revert patch from Fabio Estevam was sent on Aug 18th of 2015.
> >
> > Is there a reason why that revert patch has not been merged yet?
> > Hopefully this will be fixed before the 4.3 release.
> 
> Already reverted in Greg's tree:
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=0c727a42043f79db210cdde0366f9137b9c6bf5a
> 
> Should be available in 4.3-rc5.

Awesome, thanks!
