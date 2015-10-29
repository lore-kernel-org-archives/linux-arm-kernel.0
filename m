From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Oct 2015 08:53:42 +0100
Subject: [PATCH 2/3] ARM: zynq: DT: Add interrupt-controller property to
 GPIO
In-Reply-To: <CACRpkdY-PR1Pd+=tm49cAjayC6LQbTUH7FDqmTN-1D8aYCw5Ng@mail.gmail.com>
References: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
 <1445617532-10228-2-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdY-PR1Pd+=tm49cAjayC6LQbTUH7FDqmTN-1D8aYCw5Ng@mail.gmail.com>
Message-ID: <5631D086.9080603@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2015 05:04 PM, Linus Walleij wrote:
> On Fri, Oct 23, 2015 at 6:25 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
>> GPIO can be used as interrupt-controller. Add the missing properties to
>> the GPIO node.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied to zynq/dt.

Thanks,
Michal
