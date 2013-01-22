From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Jan 2013 23:04:41 -0800
Subject: [PATCHv3 0/7] Add pinctrl driver for Allwinner A1X SoCs
In-Reply-To: <50F9BD09.1030107@free-electrons.com>
References: <1357681398-23956-1-git-send-email-maxime.ripard@free-electrons.com>
 <50F52D2E.205@free-electrons.com>
 <CACRpkdaTFMuN1EteHLTgO7TM8BLr9P_YjuKrwuDGoPtQ57duDw@mail.gmail.com>
 <CACRpkdZPu33J2+rRkON_wih-VQgC9tg82ks=UPz3DZVqH=LCGw@mail.gmail.com>
 <50F9BD09.1030107@free-electrons.com>
Message-ID: <20130122070441.GA25783@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:22:17PM +0100, Maxime Ripard wrote:
> Hi Linus,
> 
> Thanks for your review.
> 
> On 18/01/2013 20:24, Linus Walleij wrote:
> > On Thu, Jan 17, 2013 at 2:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> On Tue, Jan 15, 2013 at 11:19 AM, Maxime Ripard
> > 
> >>> Are you ok with this version or do you have additionnal comments ?
> >>
> >> I'm probably OK with it, I've only just now reached this point in my
> >> mail backlog.
> > 
> > As noted I had more comments, they should be quick to address.
> > 
> > When finished, shall this be applied to the pinctrl tree or some other
> > subtree, like ARM SoC?
> 
> Maybe the easiest thing to do would be to push the pinctrl driver in
> itself through your tree, and the dt additions through the arm-soc one?

As long as things work without the DT pieces, that's a good way to do it for
new code (conversion of existing platforms gets more complicated most of the
time).


-Olof
