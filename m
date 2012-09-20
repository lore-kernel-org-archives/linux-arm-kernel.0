From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 16:28:07 -0700
Subject: [GIT PULL RESEND] arm-soc: vt8500: Convert mach-vt8500 to
 devicetree
In-Reply-To: <1348119906.8199.3.camel@gitbox>
References: <1348119906.8199.3.camel@gitbox>
Message-ID: <20120920232807.GA13788@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 20, 2012 at 05:45:06PM +1200, Tony Prisk wrote:
> Please disregard the last pull request - commit id's were invalid.
> This one is now correct.
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
> 
>   git://git.code.sf.net/p/linuxwmt/code tags/vt8500-for-next
> 
> for you to fetch changes up to 0cd5434aae73698aa4a48542bd8d1428d44820cb:
> 
>   arm: vt8500: Update arch-vt8500 to devicetree support. (2012-09-20 07:23:26 +1200)
> 
> ----------------------------------------------------------------
> Update mach-vt8500 to devicetree and remove non-dt code.
> 
> ----------------------------------------------------------------
> Tony Prisk (8):
>       arm: vt8500: Add device tree files for VIA/Wondermedia SoC's
>       rtc: vt8500: Add devicetree support for vt8500-rtc
>       serial: vt8500: Add devicetree support for vt8500-serial
>       video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb
>       arm: vt8500: clk: Add Common Clock Framework support
>       arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
>       arm: vt8500: gpio: Devicetree support for arch-vt8500
>       arm: vt8500: Update arch-vt8500 to devicetree support.

Overall this series looks great, however I pinged Rob Herring about it
since I didn't see his Acked-by on the bindings patch. It sounds like he
has some comments on the display pieces, so unless you can break those
out and do everything else for 3.7, we might need to hold off until that
has been settled.


-Olof
