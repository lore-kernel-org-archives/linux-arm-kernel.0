From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2016 15:10:58 +0000
Subject: [PATCH v5 6/6] ARM: dts: add dts files for Hi3519
In-Reply-To: <1452219400-32478-7-git-send-email-xuejiancheng@huawei.com>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-7-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160108151058.GN19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:16:40AM +0800, Jiancheng Xue wrote:
> +		uart0: serial at 12100000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x12100000 0x1000>;
> +			interrupts = <0 4 4>;

Should the last digit there be IRQ_TYPE_LEVEL_HIGH (and same for the
other interrupts= after this?)

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
