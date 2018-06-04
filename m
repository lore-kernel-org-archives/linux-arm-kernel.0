From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 4 Jun 2018 14:43:45 -0700
Subject: [PATCH] ARM: dts: cygnus: add ethernet0 alias
In-Reply-To: <20180503095618.2312-1-peron.clem@gmail.com>
References: <20180503095618.2312-1-peron.clem@gmail.com>
Message-ID: <40012b6c-d7c3-29b7-95cb-899bbbd008a5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2018 02:56 AM, Cl?ment P?ron wrote:
> In order to avoid Linux generating a random mac address on every boot,
> add an ethernet0 alias that will allow u-boot to patch the dtb with
> the MAC address.
> 
> Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>

Applied to devicetree/next, thanks. Next time, please do include the
proper mailing-lists, that way it does not escape my workflow involving
patchwork behind bcm-kernel-feedback-list at broadcom.com. Thank you
-- 
Florian
