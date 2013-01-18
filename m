From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jan 2013 22:22:17 +0100
Subject: [PATCHv3 0/7] Add pinctrl driver for Allwinner A1X SoCs
In-Reply-To: <CACRpkdZPu33J2+rRkON_wih-VQgC9tg82ks=UPz3DZVqH=LCGw@mail.gmail.com>
References: <1357681398-23956-1-git-send-email-maxime.ripard@free-electrons.com>
 <50F52D2E.205@free-electrons.com>
 <CACRpkdaTFMuN1EteHLTgO7TM8BLr9P_YjuKrwuDGoPtQ57duDw@mail.gmail.com>
 <CACRpkdZPu33J2+rRkON_wih-VQgC9tg82ks=UPz3DZVqH=LCGw@mail.gmail.com>
Message-ID: <50F9BD09.1030107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thanks for your review.

On 18/01/2013 20:24, Linus Walleij wrote:
> On Thu, Jan 17, 2013 at 2:31 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Jan 15, 2013 at 11:19 AM, Maxime Ripard
> 
>>> Are you ok with this version or do you have additionnal comments ?
>>
>> I'm probably OK with it, I've only just now reached this point in my
>> mail backlog.
> 
> As noted I had more comments, they should be quick to address.
> 
> When finished, shall this be applied to the pinctrl tree or some other
> subtree, like ARM SoC?

Maybe the easiest thing to do would be to push the pinctrl driver in
itself through your tree, and the dt additions through the arm-soc one?

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
