From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 21 Feb 2017 19:42:36 +0100
Subject: [PATCH V3 0/2] Add support for RK3288 Tinker board
In-Reply-To: <1487066851-25142-1-git-send-email-eddie.cai.linux@gmail.com>
References: <1487066851-25142-1-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <64714214.3fXrpx51Ln@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. Februar 2017, 18:07:29 CET schrieb Eddie Cai:
> This patch set add support for RK3288 Tinker board. Tinker board is a
> credit card size develop board powered by RK3288.
> 
> Eddie Cai (2):
>   dt-bindings: add Asus Tinker board
>   ARM: dts: rockchip: add dts for RK3288-Tinker board

applied both, with:
- fixed the wakesource pointed out by Wadim
- reordered some properties

So please double check :-)


Thanks
Heiko
