From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 12 May 2011 12:12:32 +0530
Subject: Duration of mdelay and udelay depends on MPU frequency in SMP
In-Reply-To: <BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com>
References: <BANLkTikGXzLba8uqXoffaUixBrEGj-XzRQ@mail.gmail.com>
	<BANLkTimVPnzMCL=NMb7hDkL97nJ=XdFExw@mail.gmail.com>
Message-ID: <4DCB8158.8060507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/5/2011 12:23 PM, Saquib wrote:
> Hi All,
>
> Can anyone please help me to understand and fix this issue?
>
> When CPU frequency is "1008MHz", duration of delay was close to
> theoretical value, however, when "300MHz", it was close to about 4 times
> the theoretical value.
>
> I tested it on OMAP4(SMP) blaze board.
 >
It's a well known problem if the udelay() is based of global lpj.
You can read more here [1]

Regards
Santosh
[1] http://eeek.borgchat.net/lists/arm-kernel/msg120702.html
