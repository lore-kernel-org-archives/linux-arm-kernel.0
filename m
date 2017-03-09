From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Thu, 9 Mar 2017 11:55:01 +0000
Subject: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
In-Reply-To: <20170308191419.GA12085@infradead.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com> <58BFEC7D.3090608@ti.com>
 <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com> <58C00798.1030302@ti.com>
 <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
 <20170308191419.GA12085@infradead.org>
Message-ID: <af4dd1db-dc24-1797-a43a-8487a95e47f9@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

?s 7:14 PM de 3/8/2017, Christoph Hellwig escreveu:
> On Wed, Mar 08, 2017 at 03:32:03PM +0000, Joao Pinto wrote:
>> #define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
>> 					((0x3 << 20) | (region << 9) |	\
>> 					(0x1 << 8)
> 
> Can you turn this and any similar macro into inline functions?
> 

Use an inline functions instead of macro is fine by me. In the initial patch I
implemented as a macro since it only does simple bit shifts and nothing else and
seemed simpler as a macro.

Thanks,
Joao
