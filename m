From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Mar 2011 09:54:32 +0100
Subject: [PATCH] arm: mmci: Add ARM variant with extended FIFO
In-Reply-To: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Message-ID: <AANLkTimV7eqzRNwoJ8Hoc_dvMKpsOPwW7d9TvNJ2SMR9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 6:18 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> New IO FPGA implementation for Versatile Express boards contain
> MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).

OK that's the quick fix, and deeper FIFOs are always nice.

If your hardware engineers are listening, I suggest that hardware clock
gating (as suggested in some earlier mail) plus DMA engine support will
yet improve this by orders of magnitude and also bring you less errors.

Linus Walleij
