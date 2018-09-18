From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 18 Sep 2018 16:25:18 +0300
Subject: [PATCH v3 3/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
In-Reply-To: <20180917113418.16881f6c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
 <20180917112949.414dd56f@xhacker.debian>
 <20180917113418.16881f6c@xhacker.debian>
Message-ID: <8160d36b-2fb5-c037-893c-c23568a9f6ac@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2018 06:34 AM, Jisheng Zhang wrote:
> + DT maintainers
> 
> On Mon, 17 Sep 2018 11:29:49 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
>> On some platforms, the sda/scl pins are muxed with gpio functions, so
>> they could be used for recovery. Select the gpio/default pin function
>> when prepare/unprepare recovery.
>>
>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-core.h   |  3 +++
>>   drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
