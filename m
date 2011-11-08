From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 8 Nov 2011 17:38:29 +0800
Subject: 2b034922 breaks kexec on ARM
In-Reply-To: <20111108093138.GB4392@verge.net.au>
References: <20111107185125.GA17464@mudshark.cambridge.arm.com>
 <20111107190314.GS12913@n2100.arm.linux.org.uk>
 <20111107191453.GC17464@mudshark.cambridge.arm.com>
 <20111107192043.GT12913@n2100.arm.linux.org.uk>
 <CALZhoSRZu=fbsToqWQsxJBSQ6huwxtkR=M7iFZyJ576jeJ4FHw@mail.gmail.com>
 <20111107214755.GA27679@mudshark.cambridge.arm.com>
 <20111108005922.GA15689@verge.net.au>
 <20111108090155.GZ12913@n2100.arm.linux.org.uk>
 <20111108093138.GB4392@verge.net.au>
Message-ID: <CALZhoSRD8xU5pfWT0Kx93mbQ1jqFh6wYMGTZG_kT53NnSKHzdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2011 at 5:31 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Nov 08, 2011 at 09:01:55AM +0000, Russell King - ARM Linux wrote:
>> On Tue, Nov 08, 2011 at 09:59:22AM +0900, Simon Horman wrote:
>> > Hi Will, Hi All,
>> >
>> > FWIW, as I acked this patch in the first place, I think that this patch
>> > should be reverted and a fresh version considered latter if appropriate.
>>
>> I've already reverted it - it's in my 'fixes' branch.
>
> Thanks
>

Thanks all, I would dig into it to see how to handle it correctly.

Best regards,
Lei
