From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 12 Oct 2017 19:33:50 +0200 (CEST)
Subject: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
In-Reply-To: <20170926115951.GA29367@sukzessiv.net>
References: <20170926115951.GA29367@sukzessiv.net>
Message-ID: <1245974579.189996.1507829630145@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> gohai at sukzessiv.net hat am 26. September 2017 um 13:59 geschrieben:
> 
> 
> Notifications for devices without bus or class set get dropped by
> dev_uevent_filter. Adding the class to the exported child matches
> what the gpio subsystem is doing.
> 
> With this change exporting a channel triggers a udev event, which
> gives userspace a chance to fixup permissions and makes it possible
> for non-root users to make use of the pwm subsystem.
> 
> Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: H Hartley Sweeten <hsweeten@visionengravers.com>
> CC: linux-pwm at vger.kernel.org
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-rpi-kernel at lists.infradead.org

gentle ping ...
