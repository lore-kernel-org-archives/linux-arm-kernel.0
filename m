From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Jan 2011 23:59:21 +0000
Subject: Git pull request: ux500-core for the v2.6.38 merge window
In-Reply-To: <AANLkTikDhyqcQ_=jCusJcVHrRp6hxjJ7x2W2-qbTM4jp@mail.gmail.com>
References: <AANLkTim7iBkvqHrraRkMfrvQJjPHVccmSh=01hZxSyu-@mail.gmail.com>
	<20101223144949.GO3636@n2100.arm.linux.org.uk>
	<AANLkTikDhyqcQ_=jCusJcVHrRp6hxjJ7x2W2-qbTM4jp@mail.gmail.com>
Message-ID: <20110102235920.GC17727@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 01:59:09AM +0100, Linus Walleij wrote:
> Yes, as mentioned in the original post:
> If basing this on devel is unacceptable then please
> pull this instead:
> 
>       git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> ux500-core
> 
> This brings in everything except the 5 patches from Rabin
> that require the GIC+SMP changes. I've frozen that tree
> until you pull it.

And this is what I get.  As you didn't provide me with a diffstat, I
won't push this out until you've confirmed that the following diffstat
from the merge is correct in case there's a problem.

remote: Counting objects: 374, done.
remote: Compressing objects: 100% (152/152), done.
remote: Total 320 (delta 260), reused 212 (delta 155)
Receiving objects: 100% (320/320), 61.64 KiB, done.
Resolving deltas: 100% (260/260), completed with 48 local objects.
