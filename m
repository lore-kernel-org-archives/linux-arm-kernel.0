From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 14:23:43 +0000
Subject: [PATCH DRAFT 2/2] drivers: serial: PL011: [DRAFT] implement
 register diverson for ZTE UART
In-Reply-To: <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20151103142343.GX8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 12:24:02PM +0000, Andre Przywara wrote:
> +static struct vendor_data vendor_zte = {

This is unreferenced.  What's the detection mechanism for the ZTE UART?
This is the last piece of information I need to finish my set of patches.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
