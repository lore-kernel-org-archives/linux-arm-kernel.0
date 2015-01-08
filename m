From: panand@redhat.com (Pratyush Anand)
Date: Thu, 08 Jan 2015 23:03:08 +0530
Subject: [RFC 2/8] ARM64: Refactor kprobes-arm64
In-Reply-To: <20150108165557.GQ11583@arm.com>
References: <cover.1420038188.git.panand@redhat.com>
 <9a86c217f387f45568c18b724024b0d3e040d2c6.1420038188.git.panand@redhat.com>
 <20150108165557.GQ11583@arm.com>
Message-ID: <54AEBF54.7000704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 January 2015 10:25 PM, Will Deacon wrote:
> On Wed, Dec 31, 2014 at 03:21:18PM +0000, Pratyush Anand wrote:
>> Most of the stuff of kprobes-arm64.c can also be used by uprobes.c. So
>> move all those part to common code area. In the process rename kprobe to
>> probe whereever possible.
>>
>> No functional change.
>
> In which case, can you merge this into the kprobes series (which we haven't
> merged yet)?
>

Yes, thats why these are just RFCs. I will send next version of uprobe 
only after kprobe patches are accepted into maintainer's tree.

~Pratyush

> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
