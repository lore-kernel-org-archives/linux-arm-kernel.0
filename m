From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Feb 2018 16:04:36 -0800
Subject: [PATCH 6/7] watchdog: meson: allow setting timeout in devicetree
In-Reply-To: <20180209231910.GA2251@piout.net>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-7-marcus.folkesson@gmail.com>
 <20180209224849.GH19627@roeck-us.net>
 <20180209231910.GA2251@piout.net>
Message-ID: <20180210000436.GA23513@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 12:19:10AM +0100, Alexandre Belloni wrote:
> Hi Guenter,
> 
> On 09/02/2018 at 14:48:49 -0800, Guenter Roeck wrote:
> > On Fri, Feb 09, 2018 at 08:27:23PM +0100, Marcus Folkesson wrote:
> > > watchdog_init_timeout() will allways pick timeout_param since it
> > > defaults to a valid timeout.
> > > 
> > > By following best practice described in
> > > Documentation/watchdog/watchdog-kernel-api.txt, it also
> > > let us to set timout-sec property in devicetree.
> > > 
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > 
> > Reviewed-by: Guenetr Roeck <linux@roeck-us.net>
>                   ^
> A small typo in your name
> 

Mr. Fat Fingers At Work :-)

Guenter
