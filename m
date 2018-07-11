From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 11 Jul 2018 10:45:05 +0100
Subject: [PATCH RFC 2/3] nvmem: add driver for Raspberry Pi OTP
In-Reply-To: <1520602328-28972-3-git-send-email-stefan.wahren@i2se.com>
References: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
 <1520602328-28972-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <7c1f6ee8-9572-463f-ccc8-3d12ffccb8f5@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 09/03/18 13:32, Stefan Wahren wrote:
> This patch brings read-only support for the Raspberry Pi Customer OTP.
> The driver accesses the OTP via the mailbox property interface
> provided by the VPU firmware.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   drivers/nvmem/Kconfig           |  10 +++
>   drivers/nvmem/Makefile          |   2 +
>   drivers/nvmem/raspberrypi-otp.c | 138 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 150 insertions(+)
>   create mode 100644 drivers/nvmem/raspberrypi-otp.c

Looks there are some pending trivial comments, are you planning to 
resend this?

--srini
