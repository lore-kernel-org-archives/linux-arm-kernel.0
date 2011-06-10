From: nm@ti.com (Menon, Nishanth)
Date: Fri, 10 Jun 2011 17:19:13 -0500
Subject: Duration of mdelay and udelay depends on MPU frequency in SMP
In-Reply-To: <4DCB8158.8060507@ti.com>
References: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
	<BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com>
	<4DCB8158.8060507@ti.com>
Message-ID: <BANLkTin1Tmjwjz8+J22Qi=cwu34Qp-B-wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 01:42, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/5/2011 12:23 PM, Saquib wrote:
>> Can anyone please help me to understand and fix this issue?
>>
>> When CPU frequency is "1008MHz", duration of delay was close to
>> theoretical value, however, when "300MHz", it was close to about 4 times
>> the theoretical value.
>>
>> I tested it on OMAP4(SMP) blaze board.
>
>>
> It's a well known problem if the udelay() is based of global lpj.
> You can read more here [1]
>
> Regards
> Santosh
> [1] http://eeek.borgchat.net/lists/arm-kernel/msg120702.html
I am curious about this topic now.
Searching Russel's patchworks for this:
http://www.arm.linux.org.uk/developer/patches/search.php?summary=udelay
I see nothing queued. What is the recommendation for udelay?

Regards,
Nishanth Menon
