From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Aug 2011 18:05:36 -0300
Subject: MX53Loco reports half of the total memory
In-Reply-To: <20110824205415.GN31404@pengutronix.de>
References: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
	<20110824205415.GN31404@pengutronix.de>
Message-ID: <CAOMZO5BMJN7NMXwWVmzJSV8nRS33Jv78dAv+kO7KcX-h0wjXsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Aug 24, 2011 at 5:54 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
> Try compiling the kernel with CONFIG_VMSPLIT_2G. On my board this gives:

Excellent! That did the trick.

Would you like me to submit a patch for mx5_defconfig so that CONFIG_VMSPLIT_2G
is selected by default?

Thanks,

Fabio Estevam
