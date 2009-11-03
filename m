From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 3 Nov 2009 23:06:56 +0000
Subject: [PATCH]: Remove duplicate s3c_dma_has_circular() definition
	for S3C64xx.
In-Reply-To: <4AF0B205.4040200@gmail.com>
References: <b2e8f9f70911031435x4da7d4fbuab22c453e7d02f64@mail.gmail.com>
	<20091103223949.GK23772@trinity.fluff.org>
	<4AF0B205.4040200@gmail.com>
Message-ID: <20091103230656.GL23772@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 11:43:17PM +0100, Maurus Cuelenaere wrote:
> Op 03-11-09 23:39, Ben Dooks schreef:
>> On Tue, Nov 03, 2009 at 11:35:30PM +0100, Maurus Cuelenaere wrote:
>>    
>>> This patch removes the duplicated s3c_dma_has_circular() definition and so fixes
>>> compilation for S3C64xx.
>>>      
>> removing the wrong one, we've submitted the necessary circular buffer
>> updates to allow the audio to work without causing it to lose buffers.
>>    
>
> Ah, should I resubmit a patch which removes the other one?

yes.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
