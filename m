From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 13:55:54 -0700
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Select
 CONFIG_MACH_BERLIN_BG2Q
In-Reply-To: <534D8B25.3070103@gmail.com>
References: <1395430757-8677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395430757-8677-2-git-send-email-alexandre.belloni@free-electrons.com>
 <532CB266.6050800@gmail.com> <534D8B25.3070103@gmail.com>
Message-ID: <20140505205554.GA29112@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 09:40:21PM +0200, Sebastian Hesselbarth wrote:
> On 03/21/2014 10:43 PM, Sebastian Hesselbarth wrote:
> > On 03/21/2014 08:39 PM, Alexandre Belloni wrote:
> >> Now that we support Berlin BG2Q, select CONFIG_MACH_BERLIN_BG2Q so
> >> that we can
> >> boot BG2Q based boards like the BG2Q DMP.
> >>
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Applied to berlin/soc, Thanks!
> 
> After talking to Arnd on IRC, I found out it is not my business
> taking patches for multi_v7_defconfig.
> 
> Instead of me taking it, you get my
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 

Applied, but next time please send any patch you want us to apply to
arm at kernel.org.

FWIW, it's usually how I distinguish between things to review if I have
time (personal email) and things that will need attention eventually
(arm at kernel.org). It also has the benefit of going to all current
maintainers of arm-soc without you having to worry about who it is. :)

-Olof
