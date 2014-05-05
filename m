From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 May 2014 20:10:04 -0500
Subject: [PATCH 00/15] pinctrl: sunxi: Rework and cleanups
In-Reply-To: <CACRpkdb2S0UzfeQOaqucvfKa5pvahwY3Ncm4UTcnf7NC8rTjdg@mail.gmail.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdb2S0UzfeQOaqucvfKa5pvahwY3Ncm4UTcnf7NC8rTjdg@mail.gmail.com>
Message-ID: <20140505011004.GA2937@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, May 03, 2014 at 02:22:01PM -0700, Linus Walleij wrote:
> On Mon, Apr 28, 2014 at 12:01 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > This patchset does some rework and clean up on the Allwinner pinctrl
> > driver.
> 
> This all looks good, but doesn't apply to the pinctrl devel branch.
> 
> Can you please:
> 
> 1) Address Thomas' comment on patch 1
> 
> 2) Provide me a branch, best if based on the pinctrl tree "devel"
> branch, that I can pull into the pinctrl tree for these 15 patches?

Yep, sure. I'll send a pull request.

I've modified a few things in there:
  - Addressed Thomas' comment
  - Fixed an issue with patch 14. The main pin controller is not in
    reset on the A31. Removed the code that was making a reset
    controller mandatory for that driver.
  - And I've dropped the latest patch that touches
    mach-sunxi/Kconfig. I'll merge it through my tree. That also means
    that I'll need to merge your branch. Are your branch stable?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140504/a38a2618/attachment.sig>
