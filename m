From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Dec 2015 14:29:02 +0100
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move rockchip
 to use it
In-Reply-To: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <2302646.WIa4ZQmOnV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Am Freitag, 20. November 2015, 14:22:03 schrieb Liviu Dudau:
> This is v2 of the patchset trying to make drm_of_component_probe() cope with
> finding both local crtc ports and remote encoder ones. Heiko St?bner was
> nice enough to test an earlier version that was patched following Russell's
> suggestions on rk3288, but I haven't seen any reports from iMX or Armada
> users.

these 2 patches seem to work nicely now and can probably get applied. Do you 
want to pick them up, or do you expect Mark to do this and then include them 
in a pull request?


Thanks
Heiko
