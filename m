From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 8 May 2018 16:49:56 +0100
Subject: [PATCH v2 12/27] coresight: tmc-etr: Allow commandline option to
 override SG use
In-Reply-To: <20180503204035.GA15555@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-13-git-send-email-suzuki.poulose@arm.com>
 <20180503204035.GA15555@xps15>
Message-ID: <3610e97f-87aa-3bfe-c89d-161a6bd09047@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/18 21:40, Mathieu Poirier wrote:
> On Tue, May 01, 2018 at 10:10:42AM +0100, Suzuki K Poulose wrote:
>> The Coresight TMC-ETR SG mode could be unsafe on a platform where
>> the ETR is not properly connected to account for READ operations.
>> We use a DT node property to indicate if the system is safe.
>> This patch also provides a command line parameter to "force"
>> the use of SG mode to override the firmware information.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Hi
>>
>> This is more of a debug patch for people who may want to
>> test their platform without too much of hacking. I am not
>> too keen on pushing this patch in.
> 
> I am not either nor do I personally need it to test this feature.  We can leave
> it in for now (and subsequent version) if you need it but we agree that I won't
> queue it to my tree when the time comes.

OK, I was expecting this view from most of us here. I will drop it from my series in
the next version.

Cheers
Suzuki
