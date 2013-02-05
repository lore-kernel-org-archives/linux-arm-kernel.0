From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 05 Feb 2013 20:05:49 +0100
Subject: [PATCHv2 0/3] Add support for user LED on the A13-Olinuxino
In-Reply-To: <CACRpkdZRN6ieCEbQJtHEBn0_eak_7GJ1SLHzqPJ6DQNPSCaE_Q@mail.gmail.com>
References: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdZRN6ieCEbQJtHEBn0_eak_7GJ1SLHzqPJ6DQNPSCaE_Q@mail.gmail.com>
Message-ID: <5111580D.4050100@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Le 05/02/2013 17:37, Linus Walleij a ?crit :
> On Sun, Feb 3, 2013 at 12:10 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
>> To do so, we also add a custom of_xlate function to the PIO driver so that
>> we can use a more convenient format for the gpios from the device tree.
> 
> This is now merged.

Thanks!

>> Linus, since you took the dt changes for the pinctrl driver in your tree, maybe you could merge
>> the two first patches, the second patch depending on patches in
>> your tree.
> 
> Patch 2/3 does not apply to my tree. You must have something
> more in your tree.

That's really odd. I can apply it perfectly fine on top of your
allwinner-sunxi branch in the linux-pinctrl tree here.

I tested by cherry-picking the commit 4572f97d from the branch
sunxi-3.8-04-olinuxino-leds, in the git tree found at
https://github.com/mripard/linux.git, but I can't apply it on top of my
own branches because this patch depends on the commits 874b4e45 and
9e2dcb2f you merged into your tree.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
