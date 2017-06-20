From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jun 2017 22:05:58 +0100
Subject: [PATCH 34/51] rtc: pl031: stop using rtc deprecated functions
In-Reply-To: <CACRpkdZsdwuytW5RHSdd5t9MSyYnhV1nNNKOR1VUzqEgicFqUw@mail.gmail.com>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-35-git-send-email-benjamin.gaignard@linaro.org>
 <CACRpkdZsdwuytW5RHSdd5t9MSyYnhV1nNNKOR1VUzqEgicFqUw@mail.gmail.com>
Message-ID: <20170620210558.GL4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 06:08:48PM +0200, Linus Walleij wrote:
> On Tue, Jun 20, 2017 at 11:35 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
> 
> > rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> > rely on 32bits variables and that will make rtc break in y2038/2016.
> > Stop using those two functions to safer 64bits ones.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > CC: Linus Walleij <linus.walleij@linaro.org>
> > CC: Alessandro Zummo <a.zummo@towertech.it>
> > CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > CC: rtc-linux at googlegroups.com
> > CC: linux-kernel at vger.kernel.org
> > CC: linux-arm-kernel at lists.infradead.org
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Naked-again-by: Russell King

Really, people need to stop re-posting the same patches that have
already been naked.

This patch fixes NOTHING.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
