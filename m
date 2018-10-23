From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 23 Oct 2018 09:04:01 -0500
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
In-Reply-To: <20181009112837.2517-1-peron.clem@gmail.com>
References: <20181009112837.2517-1-peron.clem@gmail.com>
Message-ID: <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On 10/09/2018 06:28 AM, Cl?ment P?ron wrote:
> Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> 
> Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.
> 

I'm not sure the need for this patch. Are there any cyclone5 based
boards that has UART1 as the debug uart? I see that all of them are
using UART0.

Dinh
