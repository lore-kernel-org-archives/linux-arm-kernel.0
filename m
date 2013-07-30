From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 30 Jul 2013 13:50:31 -0400
Subject: [PATCH] ARM: Fix r7/r11 confusion when CONFIG_THUMB2_KERNEL=y [OT]
In-Reply-To: <20130730120907.6dcc469e@armhf>
References: <1373685501-1620-1-git-send-email-jld@mozilla.com>
 <20130715135420.GG10000@mudshark.cambridge.arm.com>
 <20130720044655.GC9433@mozilla.com>
 <20130721213753.GA29879@mudshark.cambridge.arm.com>
 <20130722185234.GA14519@localhost.localdomain>
 <20130729212140.GB12681@mozilla.com>
 <20130730092517.GB2478@localhost.localdomain> <20130730113853.46cbb00a@armhf>
 <20130730094457.GC2478@localhost.localdomain> <20130730120907.6dcc469e@armhf>
Message-ID: <51F7FCE7.1040006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 06:09 AM, Jean-Francois Moine wrote:
> On Tue, 30 Jul 2013 10:44:57 +0100
> Dave Martin <Dave.Martin@arm.com> wrote:
>> On Tue, Jul 30, 2013 at 11:38:53AM +0200, Jean-Francois Moine wrote:
>>> On Tue, 30 Jul 2013 10:25:18 +0100
>>> Dave Martin <Dave.Martin@arm.com> wrote:
>>>> The pragmatic route is less contraversial and lower overhead: even though
>>>> it's not correct as per the ABI, GCC is the only supported compiler for
>>>> building the kernel anyway.  

[...]

>>> Did anybody succeed with clang?  
>>
>> Hmm, I've no idea.  Is this possible?
> 
> freebsd kernels are compiled with clang, and I heard about linux
> patches, but I did not find them yet.

There's a project home page here:

http://llvm.linuxfoundation.org/index.php/Main_Page

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
