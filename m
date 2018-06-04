From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 04 Jun 2018 12:19:39 +0200
Subject: [PATCH 0/2] Use SPDX-License-Identifier for rockchip devicetree
 files
In-Reply-To: <20171215114427.32059-1-klaus.goger@theobroma-systems.com>
References: <20171215114427.32059-1-klaus.goger@theobroma-systems.com>
Message-ID: <1700848.99AcjQORKy@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Dezember 2017, 12:44:25 CEST schrieb Klaus Goger:
> This patch series replaces all the license text in rockchip devicetree
> files text with a proper SPDX-License-Identifier.
> It follows the guidelines submitted[1] by Thomas Gleixner that are not
> yet merged.
> 
> These series also fixes the issue with contradicting statements in most
> licenses. The introduction text claims to be GPL or X11[2] but the
> following verbatim copy of the license is actually a MIT[3] license.
> The X11 license includes a advertise clause and trademark information
> related to the X Consortium. As these X Consortium specfic points are
> irrelevant for us we stick with the actuall license text.
> 
> [1] https://patchwork.kernel.org/patch/10091607/
> [2] https://spdx.org/licenses/X11.html
> [3] https://spdx.org/licenses/MIT.html
> 
> 
> Klaus Goger (2):
>   arm64: dts: rockchip: use SPDX-License-Identifier
>   ARM: dts: rockchip: use SPDX-License-Identifier

This had now 6 months for anybody concerned about this change to speak
up - with no NACKs received, so I've applied both patches for 4.19

Heiko
