From: zonque@gmail.com (Daniel Mack)
Date: Mon, 26 Aug 2013 10:22:04 +0100
Subject: [PATCH v5 0/5] dma: pdma: cyclic, residue, DMA_PRIVATE
In-Reply-To: <20130825163539.GE2748@intel.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
 <20130825163539.GE2748@intel.com>
Message-ID: <29c8fdd6-f4f6-4978-b2bc-eba86ae62c48@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> wrote:
>On Wed, Aug 21, 2013 at 02:08:53PM +0200, Daniel Mack wrote:
>> This is v5 of my series to teach the pdma driver more required
>functions.
>> 
>> In contrast to v4, it has yet again grown by one more patch (2/5),
>> which removes code that clears DCMD_ENDIRQEN at the end of the
>pending
>> chain. We want to leave of the DCMD_ENDIRQEN intact in order to
>> identify where a transaction ends.
>Applied, 1-3 & 5. The 4th one still needs some work

Thanks. I'm currently travelling and AFK. Will get back to this issue once I'm back, but that will most certainly be after the merge window has opened.


Daniel
