From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 12 Feb 2013 17:25:40 +0000
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <20130212180858.289c3efa@skate>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212180858.289c3efa@skate>
Message-ID: <511A7B14.1020107@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/13 17:08, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Fri,  8 Feb 2013 23:17:30 +0000, Ben Dooks wrote:
>> I have been working on getting big-endian kernels working, mainly from
>> little-endian boot envrionments. The following patch series is what I
>> have been working on, mainly on the highbank and axp systems.
>
> Nice!
>
>> Feedback and testing is welcome.
>
> I've tested your patch set on Armada XP. The kernel boots fine, but it
> fails to bring up the secondary CPUs:

Yes, missed updating the coherency_ll.S patch.

Attached new patch

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mvebu-be2.patch
Type: text/x-patch
Size: 1777 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/01874b7e/attachment.bin>
