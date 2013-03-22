From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Mar 2013 13:17:50 -0400
Subject: [PATCH for 3.9 v3] mmc: mvsdio: fix non-DT probing of GPIOs
In-Reply-To: <1363959023-25661-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Fri, 22 Mar 2013 14:30:23 +0100")
References: <1363959023-25661-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <874ng3l5fl.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 22 2013, Thomas Petazzoni wrote:
> Ralph Droms <rdroms@gmail.com> reported that 3.9-rc was breaking the
> SDIO interface on his Sheevaplug platform, and that the recent changes
> to the mvsdio driver are responsible for this breakage. Precisely, the
> regression has been introduced by 07728b77c03d (mmc: mvsdio: use
> slot-gpio for card detect gpio).

Thanks, pushed to mmc-next for 3.9-rc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
