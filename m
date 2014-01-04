From: bp@alien8.de (Borislav Petkov)
Date: Sat, 4 Jan 2014 11:19:01 +0100
Subject: [PATCH v4 0/6] Krait L1/L2 EDAC driver
In-Reply-To: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
References: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140104101901.GA4439@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 12:14:11PM -0800, Stephen Boyd wrote:
> This patchset adds support for the Krait L1/L2 cache error detection
> hardware. The first patch fixes a generic framework bug. The next
> two patches lay the groundwork for this driver to be added by 
> exporting percpu irq functions as well as adding the Krait l2 indirection
> register code. The next two patches add the driver and the binding and 
> the final patch hooks it all up by adding the device tree node.
> 
> I'm not sure which tree this is supposed to go through. Ideally we could
> send the first 3 plus the 5th one through an edac tree.

Sure, I can take a look at the drivers/edac/ changes but I'd need an ack
for the arch/arm/ stuff before/if I pick it up, i.e. patch 3.

Thanks.
