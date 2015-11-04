From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 4 Nov 2015 22:35:36 +0900
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <5638F5B9.3040404@arm.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
 <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
 <20151102162236.GB7637@e104818-lin.cambridge.arm.com>
 <F4C06691-60EF-45FA-9AD7-9FBF8F1960AB@gmail.com> <5638F5B9.3040404@arm.com>
Message-ID: <CC50E962-D166-44EB-A610-6F70A5234802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 4, 2015, at 2:58 AM, James Morse wrote:
> Hi Jungseok,

Hi James,

> On 03/11/15 13:49, Jungseok Lee wrote:
>> Additionally, I've been thinking of do_softirq_own_stack() which is your
>> another comment [3]. Recently, I've realized there is possibility that
>> I misunderstood your intention. Did you mean that irq_handler hook is not
>> enough? Should do_softirq_own_stack() be implemented together?
> 
> I've been putting together a version to illustrate this, I aim to post it
> before the end of this week?

It sounds great! I will wait for your version.

Best Regards
Jungseok Lee
