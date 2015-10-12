From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Oct 2015 14:39:03 -0600
Subject: bcm2835 (Raspberry Pi) KMS driver
In-Reply-To: <561A587D.6020009@lategoodbye.de>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <561A587D.6020009@lategoodbye.de>
Message-ID: <561C1A67.1060803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2015 06:39 AM, Stefan Wahren wrote:
> Am 09.10.2015 um 23:27 schrieb Eric Anholt:
>> This is a respin of the Raspberry Pi KMS series.  Now that we've got a
>> real clock driver, I can actually set new video modes.  Also in this
>> version, most of the custom DT stuff from before is gone, thanks to
>> finding exynos's platform_driver component matching code (I have sent
>> separate patches to drivers/base to make helpers for doing it).
>>
>> https://github.com/anholt/linux/tree/vc4-kms-squash-2
>
> I want to point out that git format-patch could prepare a nice cover
> letter and usually the changelog should go there.

Well, I guess you could put it there, but that wouldn't remove the need 
to put the changelog in the individual patches too, so that reviewers 
don't have to switch back and forth between different messages just to 
find out what changed in each patch.

+1 on sending the cover letter using git format-patch/send-email 
thoughl; the threading here is a little odd.
