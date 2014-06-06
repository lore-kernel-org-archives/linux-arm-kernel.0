From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 6 Jun 2014 09:11:06 +0200
Subject: [PATCH 4/9] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <CAFp+6iEKLD_rLg84h3J2oyzw7vizEV-Eqo0e_jqurx_v9ZX2JA@mail.gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-5-git-send-email-antoine.tenart@free-electrons.com>
 <CAFp+6iEKLD_rLg84h3J2oyzw7vizEV-Eqo0e_jqurx_v9ZX2JA@mail.gmail.com>
Message-ID: <20140606071106.GA30156@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 06, 2014 at 12:09:06PM +0530, Vivek Gautam wrote:
> On Thu, Jun 5, 2014 at 9:18 PM, Antoine T?nart
> <antoine.tenart@free-electrons.com> wrote:
> > Add the driver driving the Marvell Berlin USB PHY. This allows to
> > initialize the PHY and to use it from the USB driver later.
> 
> Just out of curiosity, going forward we would like to have phy drivers based on
> generic phy framework (drivers/phy).
> Any particular reason that we are still adding phy drivers in usb-phy layer ?
> 
> Looking at it, seems like it can very well be written based on phy framework.

This USB controller are ChipIdea compatible, and the ChipIdea common
functions use the usb_phy framework. That's why this PHY driver is
there.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
