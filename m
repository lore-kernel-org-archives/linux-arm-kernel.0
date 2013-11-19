From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 11:42:17 -0700
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119122801.GL16735@n2100.arm.linux.org.uk>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384798508.git.jason@lakedaemon.net>
 <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
Message-ID: <528BB109.2060201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 05:28 AM, Russell King - ARM Linux wrote:
> On Mon, Nov 18, 2013 at 03:46:32PM -0700, Stephen Warren wrote:
>> Again, the point is not that it's hard to write the script. As you
>> demonstrated, it's easy. The problem is that then, everybody has to do
>> something different for Tegra, forever. No matter how small the actual
>> cost of doing it is, it's still non-scalable to require that everyone
>> know about this special case. I'm not convinced the issue would be
>> isolated to Tegra either.
> 
> That's why there's the facility to allow an override to the script,
> just like there's the facility to override the default script when
> running "make install".

Again, you are completely missing the point about that not scaling at all.

But I will go and investigate what it takes to support renaming the
DTBs. Everyone (using Tegra) will have to update their bootloader, but
perhaps that can be dealt with.
