From: alex.shi@linaro.org (Alex Shi)
Date: Sun, 26 Nov 2017 23:02:39 +0800
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171124222004.GW31757@n2100.armlinux.org.uk>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
 <20171124202553.GV31757@n2100.armlinux.org.uk>
 <20171124222004.GW31757@n2100.armlinux.org.uk>
Message-ID: <b23d132b-8af9-cd90-1143-719d090b7ca3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/25/2017 06:20 AM, Russell King - ARM Linux wrote:
> Okay, this is what I came up with, and seems to solve the problem
> here.  It's quite a large patch though, as it shuffles around how
> we deal with exception entry, and knowing whether we should dump
> the stacked registers.  This particular patch also contains a few
> debugging bits too.

We will try your newer 2 patches: Fix ftractest issues
So guess we could skip this patch. :)

Thanks
Alex
