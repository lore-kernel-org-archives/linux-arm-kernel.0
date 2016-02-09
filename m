From: brian.starkey@arm.com (Brian Starkey)
Date: Tue, 9 Feb 2016 09:15:02 +0000
Subject: [RESEND2 PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <20160208183006.GA8429@kroah.com>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
 <20160208183006.GA8429@kroah.com>
Message-ID: <20160209091501.GA23507@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Mon, Feb 08, 2016 at 10:30:06AM -0800, Greg KH wrote:
>On Mon, Feb 08, 2016 at 05:30:50PM +0000, Brian Starkey wrote:
>> diff --git a/include/linux/io.h b/include/linux/io.h
>> index 32403b5..e2c8419 100644
>> --- a/include/linux/io.h
>> +++ b/include/linux/io.h
>> @@ -135,6 +135,7 @@ enum {
>>  	/* See memremap() kernel-doc for usage description... */
>>  	MEMREMAP_WB = 1 << 0,
>>  	MEMREMAP_WT = 1 << 1,
>> +	MEMREMAP_WC = 1 << 2,
>
>You didn't update the documentation :(
>

Maybe I missed something, but I don't think there's anything to update
here? Like the comment says, the flags are documented in the memremap()
kernel-doc (which I did update - see the next two hunks of this patch).

Thanks,

Brian
