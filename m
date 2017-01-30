From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:06:58 -0800
Subject: [PATCH v2] ARM: Import tango4_defconfig
In-Reply-To: <da9967c4-05e0-8617-08b3-e15d602d4ab9@sigmadesigns.com>
References: <5c615aa5-678e-63b8-ecae-f5f0bd8a6f2c@sigmadesigns.com>
 <4729631.76bAWajetU@wuerfel>
 <9bbc2fa7-fce4-73c2-898e-a2f780e55d1f@sigmadesigns.com>
 <CAK8P3a2ySbZRt5R3VBG=B-aAYM5XzxVSEBn=jHU2__nW=-or9A@mail.gmail.com>
 <da9967c4-05e0-8617-08b3-e15d602d4ab9@sigmadesigns.com>
Message-ID: <20170130010658.GU3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 06:43:23PM +0100, Marc Gonzalez wrote:
> Import a minimal defconfig for tango4 boards.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> diff from v1
>   drop CONFIG_CROSS_COMPILE and CONFIG_CMDLINE
> 
> Anything else sticking out? :-)
> ---
>  arch/arm/configs/tango4_defconfig | 94 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 arch/arm/configs/tango4_defconfig

Nope, looks reasonable now! Applied to next/defconfig.


Regards,


-Olof
