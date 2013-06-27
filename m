From: cjb@laptop.org (Chris Ball)
Date: Thu, 27 Jun 2013 11:56:06 -0400
Subject: [PATCH v4 0/3] mmc: dw_mmc: Add support for Rockchip variant
In-Reply-To: <201306131055.49595.heiko@sntech.de> ("Heiko \=\?utf-8\?Q\?St\?\=
 \=\?utf-8\?Q\?\=C3\=BCbner\=22's\?\= message
 of "Thu, 13 Jun 2013 10:55:48 +0200")
References: <201306131055.49595.heiko@sntech.de>
Message-ID: <87ppv7mtt5.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Thu, Jun 13 2013, Heiko St?bner wrote:
> The driver support for the mmc host is not needed for the core SoC support
> and in the same way the mmc support does not need the SoC code to function.
> Therefore it can be submitted (and hopefully merged) on its own.
>
>
> Changes since v3:
> - submit mmc driver standalone
> - add dt binding documentation

Thanks, all three patches pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
