From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 25 Feb 2011 20:53:35 +0300
Subject: [PATCH v2] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in
	module vermagic
In-Reply-To: <AANLkTimm+xqrQSWzPxxV7Kv+0NH2fpkg2HHUz=JNj3pN@mail.gmail.com>
References: <1298462021-22177-1-git-send-email-dave.martin@linaro.org>	<4D657B12.8070702@ru.mvista.com>
	<AANLkTimm+xqrQSWzPxxV7Kv+0NH2fpkg2HHUz=JNj3pN@mail.gmail.com>
Message-ID: <4D67EC9F.8010305@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Dave Martin wrote:

>>> Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
>>> guaranteed to work safely, since the kernel is not interworking-
>>> aware everywhere.
>>> This patch adds "thumb2" to the module vermagic when
>>> CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
>>> of modules into the wrong kernel.
>>> v2: modified to apply consistently on top of rmk's p2v branch.

>>   Patch changelog should follow the -- tearline.

>>> Signed-off-by: Dave Martin<dave.martin@linaro.org>
>>> Acked-by: Nicolas Pitre<nicolas.pitre@linaro.org>

  > Opinions seem to differ... I have no strong opinion on this myself.

    At least that's what Documentation/SubmittingPatches suggests:

<<
One good use for the additional comments after the "---" marker is for
a diffstat, to show what files have changed, and the number of
inserted and deleted lines per file.  A diffstat is especially useful
on bigger patches.  Other comments relevant only to the moment or the
maintainer, not suitable for the permanent changelog, should also go
here.  A good example of such comments might be "patch changelogs"
which describe what has changed between the v1 and v2 version of the
patch.
 >>

> Cheers
> ---Dave

WBR, Sergei
