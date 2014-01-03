From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jan 2014 11:29:35 -0800
Subject: DT include files (was: [GIT PULL 2/2] ARM: imx: device tree
 changes for 3.14)
In-Reply-To: <20140103030455.GB25079@S2101-09.ap.freescale.net>
References: <20131231054427.GA22383@S2101-09.ap.freescale.net>
 <20140102202108.GF19720@quad.lixom.net>
 <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
 <20140103030455.GB25079@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMihX-pLva-aBCHJ6TYfsN57MzRWiYFTnfKCXOKeja0uUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 7:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Jan 02, 2014 at 06:41:30PM -0800, Olof Johansson wrote:
>> Ok, then it's probably just the location of the header files that
>> should be adjusted. Other subsystems have placed them under
>> include/dt-bindings/<subsystem>, so that's likely a better place for
>> these as well, don't you think?
>
> I had a little discussion with DT people when the headers were firstly
> created.  These pinctrl headers are a little different from the headers
> in include/dt-bindings/<subsystem>.  The latter are used by both kernel
> and device tree sources, while the pinctrl headers are used by device
> tree sources only, so I chose to put them just in the same folder as
> dts files.  And DT people are fine with my take.

Since you don't provide references to this I had to go searching for
it. All I find is some discussion from 8 months ago, and quite a bit
of that seems to have been about changing bindings, and some about the
preprocessor behavior. Also, the patches seem to have been too big to
make it out on the lists.

I'd like a fresh look from DT people on this just to make sure no
opinions have changed -- lots of things have changed in the last 8
months w.r.t. DT.

I've pinged them on IRC, let's see if they wake up. Adding explicit cc too.


-Olof
