From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Feb 2011 18:18:09 +0000
Subject: [PATCH v2] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in
	module vermagic
In-Reply-To: <4D67EC9F.8010305@ru.mvista.com>
References: <1298462021-22177-1-git-send-email-dave.martin@linaro.org>
	<4D657B12.8070702@ru.mvista.com>
	<AANLkTimm+xqrQSWzPxxV7Kv+0NH2fpkg2HHUz=JNj3pN@mail.gmail.com>
	<4D67EC9F.8010305@ru.mvista.com>
Message-ID: <AANLkTikS4EZRgq7j6VwWH5myJK_dGCjZYZbu2iKtxNxE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 5:53 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> Dave Martin wrote:
>
>>>> Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
>>>> guaranteed to work safely, since the kernel is not interworking-
>>>> aware everywhere.
>>>> This patch adds "thumb2" to the module vermagic when
>>>> CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
>>>> of modules into the wrong kernel.
>>>> v2: modified to apply consistently on top of rmk's p2v branch.
>
>>> ?Patch changelog should follow the -- tearline.
>
>>>> Signed-off-by: Dave Martin<dave.martin@linaro.org>
>>>> Acked-by: Nicolas Pitre<nicolas.pitre@linaro.org>
>
> ?> Opinions seem to differ... I have no strong opinion on this myself.
>
> ? At least that's what Documentation/SubmittingPatches suggests:
>
> <<
> One good use for the additional comments after the "---" marker is for
> a diffstat, to show what files have changed, and the number of
> inserted and deleted lines per file. ?A diffstat is especially useful
> on bigger patches. ?Other comments relevant only to the moment or the
> maintainer, not suitable for the permanent changelog, should also go
> here. ?A good example of such comments might be "patch changelogs"
> which describe what has changed between the v1 and v2 version of the
> patch.

Fair enough.  Doesn't sounds like a inflexible rule all the same, but
when the history ceases to be relevant when the patch is merged
upstream (as in my case) is may be better to do as you suggest.  I
agree with Grant that it may sometimes be useful to preserve some of
this information in the final commit for more complex/subtle cases,
though.

I normally tidy up the cruft before sending a patch to Russell's patch
system in any case.

Cheers
---Dave
