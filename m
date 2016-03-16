From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Mar 2016 14:16:45 +0100
Subject: [PATCH v3 0/3] clk: clock driver for the Marvell Armada AP806
In-Reply-To: <1457096275-7581-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1457096275-7581-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160316141645.458f6f30@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael, Stephen,

On Fri,  4 Mar 2016 13:57:52 +0100, Thomas Petazzoni wrote:
> Michael, Stephen,
> 
> Here is a new version of the clock driver and its DT binding for the
> Marvell Armada AP806. As you will see, there is no longer any
> reference to the DFX Server and changes in the clock tree compared to
> the v2. This is due to the fact that the HW has changed from this
> point of view between the test chips and the final revision, and this
> new version aims at supporting only the final revision.

This third version of the patch series has received the ACK from Rob as
the DT binding maintainer, and from Gregory as the mvebu platform
maintainer.

Do you have any other concern about this series, or can it be applied
soon?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
