From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 05 Jul 2011 10:56:38 -0700
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of arbitrary
	physical addresses
In-Reply-To: <20110705174901.GA30531@srcf.ucam.org>
References: <201106171038.25988.ptesarik@suse.cz>
	<201107012134.45881.ptesarik@suse.cz>
	<20110701195629.GA19057@elte.hu>
	<201107012244.57593.ptesarik@suse.cz>
	<20110703194618.GB27022@elte.hu>
	<20110705174901.GA30531@srcf.ucam.org>
Message-ID: <4E135056.3060906@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2011 10:49 AM, Matthew Garrett wrote:
> On Sun, Jul 03, 2011 at 09:46:18PM +0200, Ingo Molnar wrote:
> 
>> But those tables wont be in regular RAM (they will be in ROM or in 
>> RAM marked non-RAM in a special way in the e820 tables).
>>
>> dmidecode certainly works on Fedora.
> 
> I've repeatedly wanted to dump EFI data that's flagged as E820_RESERVED 
> above the top of RAM and had to hack the kernel every time. I'm entirely 
> in favour of not having to hack the kernel every time.
> 

That definitely needs to be fixed.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
