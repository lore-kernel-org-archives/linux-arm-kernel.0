From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Apr 2014 12:52:47 -0300
Subject: USB OTG support on mx27pdk
In-Reply-To: <20140416150316.GR13429@pengutronix.de>
References: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
 <1397627716.685483508@f399.i.mail.ru>
 <CAOMZO5Bgo8L1G2hpZpg=0uVdxkcDDnkOPkNGX9dHYk3Wq9J+=w@mail.gmail.com>
 <1397649526.601497269@f431.i.mail.ru>
 <CAOMZO5DXStD5wsFhm3A9izyrxLfC8rmY2YnGBVGD=fqsJdaRFw@mail.gmail.com>
 <20140416150316.GR13429@pengutronix.de>
Message-ID: <CAOMZO5D2bkYuCqX5HYrh6qoer=i_MdqxdKQvnYHaGJ1VtL_CaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:03 PM, Michael Grzeschik <mgr@pengutronix.de> wrote:
> Yes, when this patch got reverted it will probably break usb support
> on mx6 machines. We have seen different behaviour on several mxc/mxs
> machines regarding the order of PORTSC and phy configuration.
>
> We will probably need to test all platforms before reordering this
> function call again and again for every machine using this driver.

Ok, I managed to fix the issue on mx27 without touching the chipidea driver.

Will submit the fix later today.

Regards,

Fabio Estevam
