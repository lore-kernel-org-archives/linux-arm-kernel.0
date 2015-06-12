From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 12 Jun 2015 11:05:37 +0200
Subject: [PATCH v2 06/10] pinctrl: berlin: use proper compatibles
In-Reply-To: <CACRpkda-4SahLjwe09D-Hb8p0nQFdG1Zc_xvLPwLGYQMkJQaXA@mail.gmail.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-7-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkda-4SahLjwe09D-Hb8p0nQFdG1Zc_xvLPwLGYQMkJQaXA@mail.gmail.com>
Message-ID: <20150612090537.GB29596@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 09:13:55AM +0200, Linus Walleij wrote:
> On Fri, Mar 6, 2015 at 4:05 PM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> 
> > The Berlin pin-controller driver was sharing the chip and system
> > controller nodes with the clock and the reset drivers. They all shared
> > the same compatible. With the introduction of the Marvell Berlin MFD
> > controller, the Berlin pin-controller driver has now its own node.
> > Update its compatibles to not share anymore the ones of the chip and
> > system controllers.
> >
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> Antoine, how is this series going?

The series should be in the berlin tree at the moment.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
