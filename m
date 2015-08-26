From: nschichan@freebox.fr (Nicolas Schichan)
Date: Wed, 26 Aug 2015 15:36:56 +0200
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <20150825174841.GV7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk> <55DCA0DB.7000103@freebox.fr>
 <20150825174841.GV7557@n2100.arm.linux.org.uk>
Message-ID: <55DDC0F8.5080906@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2015 07:48 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 25, 2015 at 07:07:39PM +0200, Nicolas Schichan wrote:
>> arch/arm/kernel/entry-common.S: Assembler messages:
>> arch/arm/kernel/entry-common.S:200: Error: selected processor does not support
>> ARM mode `isb'
>>
>> replacing those two "isb" occurences with "instr_sync" fixed it.
> 
> Thanks, that's exactly what I've done.  I've pushed that and the other
> fixes out for linux-next to pick up, hopefully with fewer failures.

For the code in next-20150826:

Tested-by: Nicolas Schichan <nschichan@freebox.fr>

Thanks,

-- 
Nicolas Schichan
Freebox SAS
