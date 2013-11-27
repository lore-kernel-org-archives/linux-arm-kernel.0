From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Nov 2013 12:20:54 +0000
Subject: [PATCH v5 2/7] arm64: introduce interfaces to hotpatch kernel
 and module code
In-Reply-To: <527671E9.8040704@gmail.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-3-git-send-email-liuj97@gmail.com>
 <20131030001245.GB25346@mudshark.cambridge.arm.com>
 <527671E9.8040704@gmail.com>
Message-ID: <20131127122053.GG9032@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiang Liu,

On Sun, Nov 03, 2013 at 03:55:21PM +0000, Jiang Liu wrote:
> On 10/30/2013 08:12 AM, Will Deacon wrote:
> > If I try and email you at your Huawei address, I get a bounce from the mail
> > server. Is that expected? If so, it's not very helpful from a commit log
> > perspective if you use that address as the author on your patches.
> > 
> Hi Will,
> 	Sorry for the inconvenience. I have left Huawei recently and
> have had a vacation last two weeks. I will use my gmail account next
> time.

I appreciate that you're probably not being paid to look at this anymore,
but have you had a chance to address the comments I made on version 5 of
this series? As far as I'm concerned, this is almost ready for merging and
I'd love to see it get in for 3.14!

It would be a real shame if this ended up getting dropped...

Cheers,

Will
