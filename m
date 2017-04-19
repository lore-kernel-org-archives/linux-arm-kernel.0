From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:27:05 -0700
Subject: [GIT PULL 1/4] DaVinci driver updates for v4.12
In-Reply-To: <20170404092547.32480-1-nsekhar@ti.com>
References: <20170404092547.32480-1-nsekhar@ti.com>
Message-ID: <20170419122705.GG17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 02:55:44PM +0530, Sekhar Nori wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/drivers
> 
> for you to fetch changes up to 396ff64d44dbcbd4e6c06c005c4e931bd4b35e4d:
> 
>   pata_bk3710: clear status bits of BMISP on chipset initialization (2017-03-30 16:13:04 +0530)
> 
> ----------------------------------------------------------------
> This adds a new driver for PalmChip
> PATA controller found on DM6446 and
> DM6467 SoCs. This should eventually
> replace the driver in IDE subsystem.
> 
> The patches have been acked by ATA
> maintainer.

Are you using a 40-column terminal or something? :)


Anyway, merged.


-Olof
