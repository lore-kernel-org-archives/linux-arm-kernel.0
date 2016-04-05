From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Wed, 6 Apr 2016 02:06:47 +0300
Subject: [PATCH 0/4] bam dma fixes and one dt extension
In-Reply-To: <20160405213317.GB3873@hector.attlocal.net>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <20160405213317.GB3873@hector.attlocal.net>
Message-ID: <57044507.7020207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/06/2016 12:33 AM, Andy Gross wrote:
> On Tue, Dec 01, 2015 at 11:14:55AM +0200, Stanimir Varbanov wrote:
>> Here are three bam dma fixes, which I made during testing qcrypto
>> driver. The first one is a real fix, the second one is related to
>> peripherals on which the BAM IP is initialized by remote execution
>> environment, and the third one is a sleeping bug IMO.
>>
>> The last patch is a extension again for peripherals which BAM is
>> remotely controlled by other execution environment.
>>
>> All patches has been tested on db410c board with apq8016.
>>
> 
> Stan,
> 
> Can you resend these patches w/ updates?  Or at least the remote control patch
> if you can get that out faster.  And also include the dmaengine list.

Done. Thanks for pining.

regards,
Stan
