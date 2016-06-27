From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 27 Jun 2016 10:31:29 -0500
Subject: [PATCHv5 8/8] ARM: dts: Add Arria10 Ethernet EDAC devicetree entry
In-Reply-To: <1466603939-7526-9-git-send-email-tthayer@opensource.altera.com>
References: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
 <1466603939-7526-9-git-send-email-tthayer@opensource.altera.com>
Message-ID: <577146D1.40106@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/22/2016 08:58 AM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree entries needed to support the Altera Ethernet
> FIFO buffer EDAC on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  No change
> v3  Add interrupts for SBERR and DBERR.
> v4  No change
> v5  Change "parent" phandle to "altr,ecc-parent"
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

I've applied this patch and will take through the arm-soc tree.

Thanks,
Dinh
