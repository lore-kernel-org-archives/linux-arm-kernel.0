From: krivenok.dmitry@gmail.com (Dmitry Krivenok)
Date: Tue, 8 Dec 2015 19:23:06 +0300
Subject: [PATCH] dmaengine: at_hdmac: fix dma_addr_t printing
In-Reply-To: <5666FF8F.3040005@atmel.com>
References: <24590899.3e2244jrdI@wuerfel>
	<5666FF8F.3040005@atmel.com>
Message-ID: <CAJN_NGbpeAA-JCtfUhF+VXbXkO6dGbg+=V1Wu_C7ULvr2sN8jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> A recent patch tried to improve the printk output of the atc_dump_lli()
>> function but introduced a bug

BTW, my original patch was created for mainline and was incorrectly
applied to slave-dma.git for-linus branch (I sent Vinod an email about
that).
In that branch the code was already changed so that my patch didn't
make sense there.
Now you seem to revert the change that was originally made instead of
revering my 1 line change:) Is that intentional?

Thanks,
Dmitry
