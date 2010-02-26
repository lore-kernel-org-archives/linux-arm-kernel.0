From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 26 Feb 2010 17:05:01 +0800
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100225212915.GA24043@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
Message-ID: <f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2010 at 5:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 25, 2010 at 08:51:13PM +0000, Russell King - ARM Linux wrote:
>> Err, you've rebased your tree since I last pulled it, and this now results
>> in the following, and a load of duplicated commits between the two trees.
>>
>> This is not nice, please don't rebase stuff which I've already pulled.
>>
>> I'm going to think about what to do about this; I can't trivially drop
>> your previous work from my tree.
>
> What happened to this commit?
>
> [ARM] pxa/ttc_dkb: remove duplicate macro definition
>

Hi Russell,

This one actually has been merged into 'fix' and been there in -rc8
already. Now we have to live with this duplicate commit, it's my fault.

> which follows:
>
> [ARM] pxa/raumfeld: add defconfig
> [ARM] pxa/raumfeld: add platform support
>
> in your previous pull request? ?I can find these two in your latest with
> different commit IDs, but not the pxa/ttc_dkb patch.
>

I've sorted this out by merging your devel branch back, and rebased
the remaining patches on top of it. Please try re-pull. A rough test
here at my side shows a clean merge so far.

Thanks
