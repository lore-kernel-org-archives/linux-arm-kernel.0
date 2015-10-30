From: edward.cragg@codethink.co.uk (Edward Cragg)
Date: Fri, 30 Oct 2015 17:55:24 +0000
Subject: [PATCH 1/1] ARM: meson: Add status LED for Odroid-C1
In-Reply-To: <1444401430-4396-2-git-send-email-edward.cragg@codethink.co.uk>
References: <1444401430-4396-1-git-send-email-edward.cragg@codethink.co.uk>
 <1444401430-4396-2-git-send-email-edward.cragg@codethink.co.uk>
Message-ID: <20151030175524.GD21307@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 03:37:10PM +0100, Edward Cragg wrote:
> Add the blue status LED to the Hardkernel Odroid C1 board DTS.
> This is the only programmable LED on the board.
> 
> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Hi, has anyone had a chance to have a look at this yet?

I originally forgot to add that this patch is dependent on:

[PATCH v2 0/4] Add support for Amlogic Meson8b and couple of boards

which has already been accepted.

Ed
