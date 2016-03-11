From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Mar 2016 11:56:28 +0100
Subject: [PATCH 1/5] dmaengine: sun6i: Fix the access of the IRQ register
In-Reply-To: <f2fb59f3f06600a50ce95886ad25375eafc937da.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
 <f2fb59f3f06600a50ce95886ad25375eafc937da.1457606136.git.moinejf@free.fr>
Message-ID: <20160311105628.GA8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:15:22AM +0100, Jean-Francois Moine wrote:
> The address of the IRQ register is computed, but its value was not
> used and the register access was done by the channel index instead.
> Then, only the first DMA channel was working.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/df8a2c8b/attachment.sig>
