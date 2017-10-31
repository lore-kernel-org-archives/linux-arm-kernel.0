From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 31 Oct 2017 12:58:18 +0100
Subject: [PATCH 0/7] omap: dmtimer: Move driver out of plat-omap
In-Reply-To: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
References: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20171031115818.zfftupfwmz6day6r@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 31, 2017 at 03:58:39PM +0530, Keerthy wrote:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.
>  
> Boot tested on DRA7-EVM and AM437X-GP-EVM.
> 
> More testing would be of great help.

Please resend with "--find-renames" :)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171031/bcff06f6/attachment-0001.sig>
