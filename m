From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Oct 2013 09:24:44 -0700
Subject: Regression since v3.11 on ARM shmobile ape6evm board
In-Reply-To: <20131017091317.GA30729@verge.net.au>
References: <20131017091317.GA30729@verge.net.au>
Message-ID: <52600F4C.8060202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/13 02:13, Simon Horman wrote:
> Hi,
>
> I have noticed what appears to be a regression since v3.11
> in Thierry Reding's next-20131017.
>
> The effect, when booting the ape6evm board which is based on the r8a73a4
> using its defconfig is that the boot does not proceed past the bootloader.
>
> I see the following:
>
> ## Booting kernel from Legacy Image at 41000000 ...
>    Image Name:   Linux-3.12.0-rc1-00012-g65cd4f6
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2208640 Bytes = 2.1 MiB
>    Load Address: 40008000
>    Entry Point:  40008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> I have not investigated the problem any further.
>
>
>

You're the third report. See
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204665.html
and http://www.spinics.net/lists/arm-kernel/msg279955.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
