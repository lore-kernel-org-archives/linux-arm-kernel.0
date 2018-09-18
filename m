From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 18 Sep 2018 16:40:07 +0200
Subject: [PATCH RFC 2/3] nvmem: add driver for Raspberry Pi OTP
In-Reply-To: <7c1f6ee8-9572-463f-ccc8-3d12ffccb8f5@linaro.org>
References: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
 <1520602328-28972-3-git-send-email-stefan.wahren@i2se.com>
 <7c1f6ee8-9572-463f-ccc8-3d12ffccb8f5@linaro.org>
Message-ID: <af2c4e75-816c-b9a0-00f1-5e60a0e19036@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,


Am 11.07.2018 um 11:45 schrieb Srinivas Kandagatla:
> Hi Stefan,
>
> On 09/03/18 13:32, Stefan Wahren wrote:
>> This patch brings read-only support for the Raspberry Pi Customer OTP.
>> The driver accesses the OTP via the mailbox property interface
>> provided by the VPU firmware.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>> ? drivers/nvmem/Kconfig?????????? |? 10 +++
>> ? drivers/nvmem/Makefile????????? |?? 2 +
>> ? drivers/nvmem/raspberrypi-otp.c | 138
>> ++++++++++++++++++++++++++++++++++++++++
>> ? 3 files changed, 150 insertions(+)
>> ? create mode 100644 drivers/nvmem/raspberrypi-otp.c
>
> Looks there are some pending trivial comments, are you planning to
> resend this?

yes, but this series currently have low prio.

Regards
Stefan
