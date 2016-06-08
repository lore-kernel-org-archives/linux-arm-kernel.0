From: peter@korsgaard.com (Peter Korsgaard)
Date: Wed, 08 Jun 2016 17:28:08 +0200
Subject: [PATCH] ARM: dts: sun5i: Move display blocks to sun5i.dtsi
In-Reply-To: <1465063524-4925-2-git-send-email-hdegoede@redhat.com> (Hans de
 Goede's message of "Sat, 4 Jun 2016 20:05:24 +0200")
References: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
 <1465063524-4925-2-git-send-email-hdegoede@redhat.com>
Message-ID: <87oa7bd7jr.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Hans" == Hans de Goede <hdegoede@redhat.com> writes:

 > All sun5i models share, the same die, so the display-engine is

Drop comma after share.

> identical, except for which outputs / encoders all available.

s/all/are/

 > All models support parallel / lvds lcd panels, the R8 and A10s also
 > support tv-out and the A10s also supports HDMI out.

 > This commit prepares for enabling display blocks on A10s boards,
 > but it also is a bug-fix for A10s boards, because before this commit
 > the simplefb nodes for A10s where not listing the recently added

s/where/were/

 > pll3 as clock, causing the display to go block when the kernel

s/block/black/

-- 
Bye, Peter Korsgaard
