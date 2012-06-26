From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 26 Jun 2012 19:34:18 +0200
Subject: [PATCH] ARM: zImage: Allow DTB command line concatenation with
 ATAG_CMDLINE
In-Reply-To: <alpine.LFD.2.02.1206211204430.10229@xanadu.home>
References: <1340269017-11701-1-git-send-email-richard.genoud@gmail.com>
 <alpine.LFD.2.02.1206211204430.10229@xanadu.home>
Message-ID: <CACQ1gAgeFTW_Tw05uaOeVnuDLYQ4b7XNv4xAbV249Gc01LEs8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/21 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Thu, 21 Jun 2012, Richard Genoud wrote:
>
>> This patch allows the ATAG_CMDLINE provided by the bootloader to be
>> concatenated to the bootargs property of the device tree.
>>
>> This is useful to merge static values defined in the device tree with the
>> boot loader's (possibly) more dynamic values, such as startup reasons and more.
>>
>> The bootloader should use the device tree to pass those values to the kernel,
>> but that's not always simple (old bootloader or very small one).
>>
>> The behaviour is the same as the one introduced by Victor Boivie in
>> 4394c1244249198c6b85093d46935b761b36ae05 by extending the CONFIG_CMDLINE.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>

As it has been acked by Nicolas, I sent it to the Russell's patch subsystem :

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7437/1

Richard.
