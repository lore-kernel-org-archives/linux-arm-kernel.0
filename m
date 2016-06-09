From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 9 Jun 2016 16:17:02 +0100
Subject: [PATCH v17 10/13] arm64: kdump: add VMCOREINFO for user-space
 coredump tools
In-Reply-To: <575986B5.9000701@arm.com>
References: <cover.1464974516.git.geoff@infradead.org>
 <9e75a7b75b38b37ded3e361498eaf1486107ce5d.1464974516.git.geoff@infradead.org>
 <575986B5.9000701@arm.com>
Message-ID: <5759886E.1050509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/16 16:09, Suzuki K Poulose wrote:
> On 03/06/16 19:13, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> For the current crash utility, we need to know, at least, a value of
>> "kimage_voffset" to handle the contents of core dump file (/proc/vmcore)
>> correctly due to the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
>>
>> More VMCOREINFO may be added later for makedumpfile command.
>> ---
>
> Missing Signed-off-by: ?
>
> Suzuki
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>

Please ignore the disclaimer message above


Suzuki
