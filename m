From: eric@anholt.net (Eric Anholt)
Date: Mon, 12 Oct 2015 13:53:28 -0700
Subject: bcm2835 (Raspberry Pi) KMS driver
In-Reply-To: <561C1A67.1060803@wwwdotorg.org>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <561A587D.6020009@lategoodbye.de> <561C1A67.1060803@wwwdotorg.org>
Message-ID: <8737xf6c6v.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 10/11/2015 06:39 AM, Stefan Wahren wrote:
>> Am 09.10.2015 um 23:27 schrieb Eric Anholt:
>>> This is a respin of the Raspberry Pi KMS series.  Now that we've got a
>>> real clock driver, I can actually set new video modes.  Also in this
>>> version, most of the custom DT stuff from before is gone, thanks to
>>> finding exynos's platform_driver component matching code (I have sent
>>> separate patches to drivers/base to make helpers for doing it).
>>>
>>> https://github.com/anholt/linux/tree/vc4-kms-squash-2
>>
>> I want to point out that git format-patch could prepare a nice cover
>> letter and usually the changelog should go there.
>
> Well, I guess you could put it there, but that wouldn't remove the need 
> to put the changelog in the individual patches too, so that reviewers 
> don't have to switch back and forth between different messages just to 
> find out what changed in each patch.
>
> +1 on sending the cover letter using git format-patch/send-email 
> thoughl; the threading here is a little odd.

I was using git send-email --compose.  I guess I'll play with
format-patch --cover-letter, but it seems odd that threading would be
any different between the two.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/1903f176/attachment.sig>
