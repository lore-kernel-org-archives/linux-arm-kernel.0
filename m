From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 May 2015 14:08:43 +0200
Subject: [PATCH 1/3] spi: orion: Fix maximum baud rates for Armada 370/XP
In-Reply-To: <20150526103650.GM21577@sirena.org.uk>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
 <20150526103650.GM21577@sirena.org.uk>
Message-ID: <5564624B.1030503@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 26/05/2015 12:36, Mark Brown wrote:
> On Tue, May 26, 2015 at 11:44:42AM +0200, Gregory CLEMENT wrote:
> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Reported-by: Kostya Porotchkin <kostap@marvell.com>
>> Cc: <stable@vger.kernel.org> #Fixes df59fa7f4bca
> 
> Applied, but please format this stuff in a standard fashion - use a
> Fixes: tag to reference commits you're fixing.  This makes it easier for
> tooling to work with the information you're providing.

Yes, sure, I will do. I followed the Documentation/stable_kernel_rules.txt
file and I missed the new information in Documentation/SubmittingPatches
about this tag.

Thanks,

Gregory




-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
