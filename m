From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 23 Dec 2014 11:23:18 -0500
Subject: kernel.org - master not booting on keystone (ARM v7 Cortex A15
 SoC) EVMs
In-Reply-To: <54997AC2.1040507@linaro.org>
References: <549490D6.3090804@ti.com> <20141219211816.GH10857@pengutronix.de>
 <CANMBJr5T6SJFiw4HwvK0cfJsyrM8WTPU6_aK0uzznEV4Mqcg3w@mail.gmail.com>
 <5494B932.6060602@ti.com> <20141221102925.GJ10857@pengutronix.de>
 <54983304.3080302@ti.com> <54997AC2.1040507@linaro.org>
Message-ID: <549996F6.1010008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2014 09:22 AM, Grygorii.Strashko at linaro.org wrote:
> +       phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +       phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);

Grygorii,

This works fine on my board. Could you send the patch to the list to 
address this issue? You can add my Tested-By if needed.

Tested-By: Murali Karicheri <m-karicheri2@ti.com>

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
