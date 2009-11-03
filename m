From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 03 Nov 2009 23:43:17 +0100
Subject: [PATCH]: Remove duplicate s3c_dma_has_circular() definition for
	S3C64xx.
In-Reply-To: <20091103223949.GK23772@trinity.fluff.org>
References: <b2e8f9f70911031435x4da7d4fbuab22c453e7d02f64@mail.gmail.com>
	<20091103223949.GK23772@trinity.fluff.org>
Message-ID: <4AF0B205.4040200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 03-11-09 23:39, Ben Dooks schreef:
> On Tue, Nov 03, 2009 at 11:35:30PM +0100, Maurus Cuelenaere wrote:
>    
>> This patch removes the duplicated s3c_dma_has_circular() definition and so fixes
>> compilation for S3C64xx.
>>      
> removing the wrong one, we've submitted the necessary circular buffer
> updates to allow the audio to work without causing it to lose buffers.
>    

Ah, should I resubmit a patch which removes the other one?

Regards,
Maurus Cuelenaere
