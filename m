From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 05 Jul 2011 15:34:51 -0700
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of arbitrary
	physical addresses
In-Reply-To: <20110705174901.GA30531@srcf.ucam.org>
References: <201106171038.25988.ptesarik@suse.cz>
	<201107012134.45881.ptesarik@suse.cz>
	<20110701195629.GA19057@elte.hu>
	<201107012244.57593.ptesarik@suse.cz>
	<20110703194618.GB27022@elte.hu>
	<20110705174901.GA30531@srcf.ucam.org>
Message-ID: <4E13918B.3040208@zytor.com>
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

Alright... I must admit I have lost track...

Where are we at with this patchset, and what path should it go through?

	-hpa
