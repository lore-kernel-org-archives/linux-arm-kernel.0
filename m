From: zhangfei.gao@linaro.org (zhangfei)
Date: Sat, 04 Oct 2014 08:22:50 +0800
Subject: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <20141003164851.GA1481@katana>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
 <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
 <20141003120926.GF1349@katana> <542EA15B.70605@linaro.org>
 <20141003164851.GA1481@katana>
Message-ID: <542F3DDA.9060607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/04/2014 12:48 AM, Wolfram Sang wrote:
>> Currently Wei help do the test via I2C device interface, on a specific board
>> with i2c device.
>> We do the test after the board is up, also no i2c activity during probe.
>
> Huh, so the driver has not been tested with a real i2c slave so far? Or
> am I misunderstanding something?

Sorry for the confusion

It is tested via e2prom,
Write group of data then read back to check whether they are same or not.
We use I2C device interface, and only run the test application when 
board is up.

Thanks
