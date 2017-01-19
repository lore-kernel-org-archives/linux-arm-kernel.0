From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2017 13:57:50 -0200
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <20170119145642.GC27312@n2100.armlinux.org.uk>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
 <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
 <20170119145642.GC27312@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5AkD9n-9cJRQCkj_g+=HeSWzKHQ=9UB81WXa-0LkWP1xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 12:56 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Frankly, I think the original change (removing the skeleton.dtsi include)
> was misguided and needs to be reverted - the change is imho built upon an
> incorrect assumption that nothing in skeleton.dtsi is required.  That's
> clearly false.

Wouldn't this v2 patch restore things back to normal?
