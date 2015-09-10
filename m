From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 10 Sep 2015 13:29:41 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150910104930.GI21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 10 Sep 2015 11:49:30 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
 <m3a8su4llv.fsf@t19.piap.pl>
 <20150910104930.GI21084@n2100.arm.linux.org.uk>
Message-ID: <m3613i4imy.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>>From a quick read of the imx-drm ipuv3-plane code, it looks like it
> doesn't bother with the U/V planes for planar images.  Nothing looks
> at fb->offsets[1,2] nor fb->pitches[1,2].  However, it claims to
> support DRM_FORMAT_YUV420 and DRM_FORMAT_YVU420 formats - which is
> wrong if it doesn't look at these other offsets and pitches.

Well... I have to agree.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
