From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Jan 2017 18:34:04 +0100
Subject: [PATCH v2 8/8] ARM: dts: kirkwood-rd88f6281: Utilize new DSA
 binding
In-Reply-To: <20170105192957.14304-9-f.fainelli@gmail.com>
References: <20170105192957.14304-1-f.fainelli@gmail.com>
 <20170105192957.14304-9-f.fainelli@gmail.com>
Message-ID: <20170117173404.GG9470@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 11:29:57AM -0800, Florian Fainelli wrote:
> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
> Document new binding"). The legacy binding node is kept included, but is marked
> disabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts | 11 ++++++++
>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 44 +++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)

Hi Florian

What about arch/arm/boot/dts/kirkwood-rd88f6281-a.dts

     Andrew
