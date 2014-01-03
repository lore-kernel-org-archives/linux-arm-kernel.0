From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Jan 2014 11:04:57 +0800
Subject: DT include files (was: [GIT PULL 2/2] ARM: imx: device tree
 changes for 3.14)
In-Reply-To: <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
References: <20131231054427.GA22383@S2101-09.ap.freescale.net>
 <20140102202108.GF19720@quad.lixom.net>
 <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
Message-ID: <20140103030455.GB25079@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 06:41:30PM -0800, Olof Johansson wrote:
> Ok, then it's probably just the location of the header files that
> should be adjusted. Other subsystems have placed them under
> include/dt-bindings/<subsystem>, so that's likely a better place for
> these as well, don't you think?

I had a little discussion with DT people when the headers were firstly
created.  These pinctrl headers are a little different from the headers
in include/dt-bindings/<subsystem>.  The latter are used by both kernel
and device tree sources, while the pinctrl headers are used by device
tree sources only, so I chose to put them just in the same folder as
dts files.  And DT people are fine with my take.

Shawn
