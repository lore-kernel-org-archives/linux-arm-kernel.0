From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 3 May 2018 09:32:46 -0500
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
In-Reply-To: <20180503121342.14178-1-peron.clem@gmail.com>
References: <20180503121342.14178-1-peron.clem@gmail.com>
Message-ID: <4da58449-af42-827c-09ff-6789e78f8e97@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On 05/03/2018 07:13 AM, Cl?ment P?ron wrote:
> Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> 
> Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.
> 

Do you have a Cyclone5/Arria5 board that is using UART1 for the debug port?

Dinh
