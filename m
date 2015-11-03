From: james.morse@arm.com (James Morse)
Date: Tue, 03 Nov 2015 17:58:17 +0000
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <F4C06691-60EF-45FA-9AD7-9FBF8F1960AB@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
 <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
 <20151102162236.GB7637@e104818-lin.cambridge.arm.com>
 <F4C06691-60EF-45FA-9AD7-9FBF8F1960AB@gmail.com>
Message-ID: <5638F5B9.3040404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jungseok,

On 03/11/15 13:49, Jungseok Lee wrote:
> Additionally, I've been thinking of do_softirq_own_stack() which is your
> another comment [3]. Recently, I've realized there is possibility that
> I misunderstood your intention. Did you mean that irq_handler hook is not
> enough? Should do_softirq_own_stack() be implemented together?

I've been putting together a version to illustrate this, I aim to post it
before the end of this week...


Thanks,

James
