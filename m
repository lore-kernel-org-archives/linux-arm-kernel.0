From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 12 Feb 2015 12:01:10 +0100
Subject: [PATCH v2] ARM: dts: zynq: Add OCM node
In-Reply-To: <20150212105443.GB1522@leverpostej>
References: <6df19b400e314ef8228be475bb8ba83765683016.1423737765.git.michal.simek@xilinx.com>
 <20150212105443.GB1522@leverpostej>
Message-ID: <c64e7b4bf78649049cea3dceecea453c@BN1AFFO11FD014.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2015 11:54 AM, Mark Rutland wrote:
> On Thu, Feb 12, 2015 at 10:42:47AM +0000, Michal Simek wrote:
>> Add OCM node for all zynq boards. OCM location
>> can changed but for all current boards this
>> is the location where OCM is.`
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Move node to board file suggested by Mark
>>
>> This patch is done based on discussion here.
>> https://lkml.org/lkml/2014/12/1/396
>>
>> Mark: I expect you won't like amba bus reference or
>> am I wrong?
> 
> I'm fine with dropping things onto a bus in this way. If we're happy to
> do it for other nodes I don't see why busses should be special.

Wonderful. I will give people some time to comment this style.

Thanks for your comments,
Michal
