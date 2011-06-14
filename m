From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Jun 2011 20:24:27 -0700
Subject: Duration of mdelay and udelay depends on MPU frequency in SMP
In-Reply-To: <BANLkTin1Tmjwjz8+J22Qi=cwu34Qp-B-wQ@mail.gmail.com>
References: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>	<BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com>	<4DCB8158.8060507@ti.com>
	<BANLkTin1Tmjwjz8+J22Qi=cwu34Qp-B-wQ@mail.gmail.com>
Message-ID: <4DF6D46B.90806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2011 03:19 PM, Menon, Nishanth wrote:
> On Thu, May 12, 2011 at 01:42, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>>
>> It's a well known problem if the udelay() is based of global lpj.
>> You can read more here [1]
>>
>> Regards
>> Santosh
>> [1] http://eeek.borgchat.net/lists/arm-kernel/msg120702.html
> I am curious about this topic now.
> Searching Russel's patchworks for this:
> http://www.arm.linux.org.uk/developer/patches/search.php?summary=udelay
> I see nothing queued. What is the recommendation for udelay?

The patches are sitting in Russell's patch tracker, waiting for him to
accept/reject them.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6874/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6875/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6873/1

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
