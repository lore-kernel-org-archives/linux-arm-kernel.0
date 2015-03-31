From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 31 Mar 2015 13:25:07 +0200
Subject: [PATCH] spi: xilinx: Use standard num-cs binding
In-Reply-To: <20150331111651.GL2869@sirena.org.uk>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
 <20150308190012.GV28806@sirena.org.uk>
 <2a81c738-f7e2-4387-b04c-05c9892ba8e4@BN1AFFO11FD026.protection.gbl>
 <20150327175318.GG1743@sirena.org.uk>
 <1bd88fda-314c-496a-ba8b-e9292f9c411b@BY2FFO11FD023.protection.gbl>
 <20150331054714.GA2869@sirena.org.uk>
 <74214fc9-e5e4-42db-bd85-51ed02975388@BN1AFFO11FD026.protection.gbl>
 <20150331111651.GL2869@sirena.org.uk>
Message-ID: <98b110d7-f875-4bd5-98de-47641ac2134c@BN1AFFO11FD026.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2015 01:16 PM, Mark Brown wrote:
> On Tue, Mar 31, 2015 at 10:16:57AM +0200, Michal Simek wrote:
>> On 03/31/2015 07:47 AM, Mark Brown wrote:
> 
>>> num-cs *is* a software setting.
> 
>> ok - what to do with that? Remove it because it shouldn't be passed via DT?
> 
> Well, there's a lot of existing users to check and clean up some of
> which currently rely on it which will take time to deal with.  Removing
> it while some drivers rely on using it isn't ideal.
> 

We have spi-cadence driver in the kernel which uses num-cs and also
is-decoded-cs and we can change it but the question still remains how
to do it better.

Thanks,
Michal
