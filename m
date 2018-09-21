From: bp@alien8.de (Borislav Petkov)
Date: Fri, 21 Sep 2018 14:57:01 +0200
Subject: [PATCH v7 6/7] arm64: zynqmp: Add DDRC node
In-Reply-To: <1537194305-9243-7-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-7-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180921125701.GF30439@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:55:04PM +0530, Manish Narani wrote:
> Add ddrc memory controller node in dts. The size mentioned in dts is
> 0x30000, because we need to access DDR_QOS INTR registers located at
> 0xFD090208 from this driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Still needs DT folks ACK.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
