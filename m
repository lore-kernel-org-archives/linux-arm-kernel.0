From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Nov 2011 22:08:34 +0000
Subject: GIC irq_start detection breaks 3.2 boot on platforms without PPIs
In-Reply-To: <20111125154157.GP12047@mudshark.cambridge.arm.com>
References: <20111124163548.GC22031@mudshark.cambridge.arm.com>
 <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
 <20111125154157.GP12047@mudshark.cambridge.arm.com>
Message-ID: <20111126220834.GB9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 03:41:57PM +0000, Will Deacon wrote:
> Ok, if you're happy with my logic then I can put the patch into Russell's
> patch system.

I've merged this into my fixes branch, but when I re-merge this with
Marc's irqchip consolidation, I get conflicts.  I think I've fixed it
correctly, but please check the result, which you'll find in my for-next
branch.

Thanks.
