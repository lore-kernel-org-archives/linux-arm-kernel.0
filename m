From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Jan 2013 23:17:57 -0800
Subject: [PATCH 7/7] ARM: sunxi: olinuxino: Add muxing for the uart
In-Reply-To: <CACRpkdbUbD-VnkdSAKp=GyRiqub8iZf90nwPHPFtWZHwSMZiAA@mail.gmail.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
 <1358544639-14761-8-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdbUbD-VnkdSAKp=GyRiqub8iZf90nwPHPFtWZHwSMZiAA@mail.gmail.com>
Message-ID: <20130122071757.GB25783@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 11:15:32PM +0100, Linus Walleij wrote:
> On Fri, Jan 18, 2013 at 10:30 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> All pinctrl and device tree patches applied to my allwinner branch in the
> pinctrl tree. Hope the ARM SoC can accept me poking around in your
> device trees.

Ah, my just-now sent reply was to an older version of this thread.

Sure, it's not a big deal that you're picking up the DT changes, but there
might end up being add/add conflicts if they are adding more stuff to the same
files. Not a huge deal, ideally we want to avoid them but a couple are ok.


-Olof
