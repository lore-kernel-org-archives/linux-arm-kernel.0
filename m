From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 11 Oct 2013 15:47:39 +0200
Subject: New big-endian patch series against 3.12-rc4
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20131011154739.0574e95a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed,  9 Oct 2013 00:34:16 +0200, Ben Dooks wrote:
> This is a new series for big-endian on ARM re-based onto 3.12-rc4
> and updated with new patches from Victor to fix regressions since 3.11.
> 
> I have not been able to test this further than building it as I do not
> currently have access to any hardware, however there where no big issues
> when re-basing. Thanks to Marc Zyngier for pointing out the need for a
> rebase.
> 
> The branch is at:
> 
>   git://git.baserock.org/delta/linux baserock/bjdooks/3.12-rc4/core

I've tested this branch on Armada XP GP in the following configurations:

 * little-endian ARM
 * little-endian Thumb2
 * big-endian ARM
 * big-endian Thumb2

The four configurations booted successfully without any problem, and
devices appear to work as expected.

I'm all for getting this merged for 3.13. The code has been around for
a while, tested many times by various persons, reviewed by several ARM
people.

Thanks Ben for taking care of this series!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
