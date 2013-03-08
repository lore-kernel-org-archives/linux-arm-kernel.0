From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 16:58:18 -0500
Subject: [PATCH] ARM: Dove: add RTC device node
In-Reply-To: <20130308121317.4ee83c0a@armhf>
References: <20130308121317.4ee83c0a@armhf>
Message-ID: <20130308215818.GU23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 12:13:17PM +0100, Jean-Francois Moine wrote:
> The commit 48be9ac930086f removed the RTC initialization.
> This patch re-enables the RTC via the DT.
> 
> Signed-off-by: Jean-Fran?ois Moine <moinejf@free.fr>
> ---
>  arch/arm/boot/dts/dove.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)

Applied to mvebu/fixes with the following commit entry:

    ARM: Dove: add RTC device node

    The commit:

      48be9ac ARM: Dove: split legacy and DT setup

    removed the RTC initialization.  This patch re-enables the RTC
    via the DT.


thx,

Jason.
