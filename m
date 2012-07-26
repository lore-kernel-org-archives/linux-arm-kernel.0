From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 16:24:42 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <50116005.6050008@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <501150E5.6010503@linaro.org>
 <20120726144336.GL3099@opensource.wolfsonmicro.com>
 <50116005.6050008@linaro.org>
Message-ID: <20120726152442.GR3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:19:33PM +0100, Lee Jones wrote:

> Okay, so your suggestion is to strip out all of the sub-devices
> under the AB8500. It's doable, but will take some restructuring and
> thinking about. This is a job for another day. I think it's okay to
> continue with the current semantics for the time-being. The line
> we're discussing does need to be split out though. I didn't mean to
> merge it in with the ASoC stuff.

Yes, well any that aren't reusable at any rate.  If you could relocate
the device into another SoC integation that'd be different.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/f328f81b/attachment.sig>
