From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 09 Feb 2013 17:09:42 +0000
Subject: [PATCH 06/17] ARM: fixup head for atag verification
In-Reply-To: <alpine.LFD.2.02.1302082246400.6300@xanadu.home>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-7-git-send-email-ben.dooks@codethink.co.uk>
 <alpine.LFD.2.02.1302082246400.6300@xanadu.home>
Message-ID: <aa110730c75b32e6594dcaa251668a33@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 03:51, Nicolas Pitre wrote:
> On Fri, 8 Feb 2013, Ben Dooks wrote:
>
>> If we booted LE but running BE8, ensure we read ATAGs data from head 
>> code
>> in the correct mode.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> You must be working on some recent platform, right?  Your cover 
> letter
> mention highbank.  Strange that you don't address the DT pointer
> validation as well.

I am using highbank for my main tests, I believe the DT pointer is
correct as the data is always guaranteed to be BE and the kernel
is doing the correct thing to test for it.

I will re-check this, but it all looked fine when I went through it.

-- 
Ben
