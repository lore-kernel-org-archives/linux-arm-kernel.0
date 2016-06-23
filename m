From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 23 Jun 2016 12:06:10 -0400
Subject: [PATCH] arm64:swiotlb:Enable only when Input size through command
 line
In-Reply-To: <20160623143034.GN6521@e104818-lin.cambridge.arm.com>
References: <1466684020-5224-1-git-send-email-manjeet.p@samsung.com>
 <20160623143034.GN6521@e104818-lin.cambridge.arm.com>
Message-ID: <9A15F5E5-775E-4079-961F-67FD54B8F2F4@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On June 23, 2016 10:30:34 AM EDT, Catalin Marinas <catalin.marinas@arm.com> wrote:
>On Thu, Jun 23, 2016 at 05:43:40PM +0530, Manjeet Pawar wrote:
>> From: Rohit Thapliyal <r.thapliyal@samsung.com>
>> 
>> swiotlb default size of 64M is too big as
>> default value therefore it is made configurable
>> through command line through swiotlb_size parameter.
>> swiotlb allocation shall be done only when the
>> swiotlb size is given through command line.
>> Otherwise no swiotlb is allocated.
>
>I already queued this patch:
>
>http://lkml.kernel.org/g/1465372426-4077-1-git-send-email-jszhang at marvell.com
>
>If you have any objections to it, please reply there.


I do (sorry about duplicate email, the other got rejected by mailing lists).

Why not expand the swiotlb= parameter instead of introducing a new one?

Also, why not use the swiotlb by itself? That does the job as well?
