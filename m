From: bp@alien8.de (Borislav Petkov)
Date: Wed, 7 Jan 2015 11:54:30 +0100
Subject: [PATCH v8] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <a728a8d4678f4dbf9de189a480297c3d@BY2FFO11FD034.protection.gbl>
References: <a728a8d4678f4dbf9de189a480297c3d@BY2FFO11FD034.protection.gbl>
Message-ID: <20150107105430.GA3984@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 11:13:47PM +0530, Punnaiah Choudary Kalluri wrote:
> Added EDAC support for reporting the ecc errors of synopsys ddr controller.
> The ddr ecc controller corrects single bit errors and detects double bit
> errors.
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>

Applied and queued for 3.20,
thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
