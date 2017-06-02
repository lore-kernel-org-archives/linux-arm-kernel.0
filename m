From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jun 2017 13:07:02 +0100
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
Message-ID: <20170602120702.GM22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 10:31:10AM +0200, Hans Verkuil wrote:
> This will change. Patches to fix the config handling are pending for 4.12.
> 
> Here you can see the pending patches:
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=drm-cec
> 
> The patches from 'cec-notifier.h: handle unreachable CONFIG_CEC_CORE' to
> 'cec: drop MEDIA_CEC_DEBUG' should all be merged in 4.12.

Hi Hans,

I'll wait until these have hit mainline before generating another
patch series.  Do you have any idea when that might happen?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
