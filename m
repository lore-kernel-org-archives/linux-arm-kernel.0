From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 10:25:07 -0700
Subject: [resend GIT PULL] ARM: mediatek: dts updates for v4.3
In-Reply-To: <CABuKBeJA9rYZm4keLV8TVj_X4FT4YkOcmFJqnCBL=aaQWW4N1g@mail.gmail.com>
References: <CABuKBeJA9rYZm4keLV8TVj_X4FT4YkOcmFJqnCBL=aaQWW4N1g@mail.gmail.com>
Message-ID: <20151023172507.GJ2224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2015 at 02:21:54PM +0200, Matthias Brugger wrote:
> Hi Arnd and Olof,
> 
> Please pull the following patches.
> 
> I resend this pull request, because I forgot to add the arm mailing
> list in the first place.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:
> 
>   Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.3-next-dts
> 
> for you to fetch changes up to 060646a218b357e758b3dc6bbce2865bd0aadd44:
> 
>   ARM: dts: mt8127: enable basic SMP bringup for mt8127 (2015-10-12
> 19:10:38 +0200)
> 
> ----------------------------------------------------------------
> Delete regulator-compatible usage in mt8135-evbp1.dts.
> The regualtor-compatible binding is deprecated, instead the node name
> is used.
> 
> Mediatek timer driver supports as well mt8127, mt8135 and mt8173. Add
> these SOCs to the bindings list.
> 
> Power domains venc and venc_lt need clocks two extra clocks to access
> their registers. We update the bindings documentation about this.
> 
> Update SMP bindings documentation by adding support for mt6589 and mt81xx SOCs.
> 
> Update mt8127.dtsi and mt8135.dtsi to enable SMP support.

Merged, thanks.


-Olof
