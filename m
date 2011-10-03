From: hemantp@ti.com (Pedanekar, Hemant)
Date: Mon, 3 Oct 2011 22:15:07 +0530
Subject: [PATCH v3 3/3] ARM: OMAP: TI814X: Create board support and
	enable build for TI8148 EVM
In-Reply-To: <4E88542B.4010206@compulab.co.il>
References: <1317258570-30494-1-git-send-email-hemantp@ti.com>
	<4E88542B.4010206@compulab.co.il>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC5D52@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

Igor Grinberg wrote on Sunday, October 02, 2011 5:38 PM:

> Hi Hemant,
> 
> On 09/29/11 04:09, Hemant Pedanekar wrote:
>> This patch adds minimal support and build configuration for TI8148 EVM.
>> Also adds support for low level debugging on UART1 console on the EVM.
>> 
>> Note that existing TI8168 EVM file (board-ti8168evm.c) is updated with
>> machine info for TI8148 EVM and renamed as board-ti81xxevm.c.
> 
> Should we really rename the existing file?
> Shouldn't we just stick to the name of the file submitted first?
> (e.g. board-ti8168evm.c) and just add the support for the new
> TI8148 EVM in to the existing file?

But won't this be misleading?

Thanks.

   Hemant

> Because, I don't see any real necessity in renaming that file.
> Also, it will spare the changes in Makefile.
>

[...]
