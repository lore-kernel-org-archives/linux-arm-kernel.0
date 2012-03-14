From: cjb@laptop.org (Chris Ball)
Date: Wed, 14 Mar 2012 11:37:24 -0400
Subject: [PATCH v2 0/4] omap hsmmc device tree support
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Mon, 12 Mar 2012 20:32:36 +0530")
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Message-ID: <87pqcfdwi3.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 12 2012, Rajendra Nayak wrote:
> The series adds device tree support for OMAP hsmmc
> driver.
>
> Changes in V2:
> -1- Minor fixes based on comments from Grant.
> -2- Added a seperate compatible for omap3.
> -3- Added a new binding "ti,needs-special-reset"
> to handle some mmc modules which need special
> softreset sequence.
> -4- Updated board dts files with "status = disable;"
> for unused mmc modules.
>
> Rob,
> I retained your ack on patch 1 despite the additional
> binding that I added to handle the special softreset
> sequence. Let me know if you have any issues with it.
>
> Chris.
> Patch 1 and Patch 2 apply cleanly on mmc-next and can
> be taken in from the mmc tree after relevent acks from
> DT folks.
> Patch 3 and Patch 4 which update dts files, I plan to
> push via linux-omap/Tony's tree.

Thanks, I've pushed patches 1 and 2 to mmc-next for 3.4, with Balaji's
Tested-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
