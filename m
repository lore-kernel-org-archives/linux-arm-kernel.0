From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 26 Sep 2018 13:35:15 +0200
Subject: [PATCH v3] arm64: dts: rockchip: add initial dts support for
 Rockpro64
In-Reply-To: <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
 <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
Message-ID: <6748636.LqZcXZ9sFQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. September 2018, 08:24:57 CEST schrieb Akash Gajjar:
> Rockpro64 is a rockchip RK3399 based board from pine64.org.
> This patch adds basic device node support for Rockpro64 board and make it able
> to bring up.
> 
> Peripheral Works
> - Sdcard
> - USB 2.0, 3.0
> - Leds
> - Ethernet
> - Debug console
> 
> Not working:
> - USB Type-C
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

applied for 4.20.

For future patches, please keep in mind to transfer received tags from
one version to the next. v2 received a "Reviewed-by" from Rob, so ideally
it should have been included below your Signed-off in v3.

I've picked that tag myself from v2, so no need to do anything now,
just for the next time ;-)

Thanks
Heiko
