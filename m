From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 24 Nov 2015 00:20:14 +0100
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move rockchip
 to use it
In-Reply-To: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1737461.8xCM7oo5S1@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 20. November 2015, 14:22:03 schrieb Liviu Dudau:
> Hello,
> 
> This is v2 of the patchset trying to make drm_of_component_probe() cope with
> finding both local crtc ports and remote encoder ones. Heiko St?bner was
> nice enough to test an earlier version that was patched following Russell's
> suggestions on rk3288, but I haven't seen any reports from iMX or Armada
> users.
> 
> Changelog:
>  v2: Updated the drm_of_component_probe() comment to explain why the
> reference count is not dropped. Fixed the compare_port() function for
> rockchip as described by Russell.

Now works nicely on my rk3288-veyron-jerry again.

Tested-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko
