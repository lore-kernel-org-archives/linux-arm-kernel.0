From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 20:54:20 +0800
Subject: [PATCH v2 0/3] Add ZTE zx-irdec remote control driver
In-Reply-To: <1501420993-21977-1-git-send-email-shawnguo@kernel.org>
References: <1501420993-21977-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170818125418.GM7608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 30, 2017 at 09:23:10PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The series adds dt-bindings and remote control driver for IRDEC block
> found on ZTE ZX family SoCs.
> 
> Changes for v2:
>  - Add one patch to move generic NEC scancode composing and protocol
>    type detection code from ir_nec_decode() into an inline shared
>    function, which can be reused by zx-irdec driver.
> 
> Shawn Guo (3):
>   rc: ir-nec-decoder: move scancode composing code into a shared
>     function
>   dt-bindings: add bindings document for zx-irdec
>   rc: add zx-irdec remote control driver

Hi Sean,

We are getting close to 4.14 merge window.  Can we get this into -next
for a bit exposure, if you are fine with the patches?

Shawn
