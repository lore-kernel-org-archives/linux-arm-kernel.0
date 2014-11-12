From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 13 Nov 2014 00:32:44 +0100
Subject: [PATCH] ARM: dts: rockchip: fix invalid unit-address in
 rk3188.dtsi
In-Reply-To: <1415407496-18507-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <5384745.1WqprI8GVl@diego>
 <1415407496-18507-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <1834074.A8oL01ENBp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 8. November 2014, 01:44:56 schrieb Julien CHAUVEAU:
> Unit addresses, whilst written in hex, don't contain a 0x prefix.
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

added this to my v3.19-armsoc/dts branch
