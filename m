From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 14 Feb 2014 18:07:16 +0900
Subject: [PATCH v4] ARM: shmobile: Add defconfig for shmobile mulitplatfom
In-Reply-To: <1392354403-30260-1-git-send-email-horms+renesas@verge.net.au>
References: <1392354403-30260-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoT5C432uQF6yG76PeMopF7HfqQDSyJ5SMF_77RsyC9DxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 2:06 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This is intended to be a base for a defconfig to cover all
> shmobile multiplatform boards. It currently includes configuration
> for the following boards:
>
> * KZM9D
> * Lager
> * Koelsch
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v4
> * Account for removal of CONFIG_KZM9D
>   - Do not select CONFIG_MACH_KZM9D
>   - Select CONFIG_SMSC_PHY and CONFIG_REGULATOR_FIXED_VOLTAGE

Thanks Simon!

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
