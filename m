From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jun 2012 20:08:27 +0800
Subject: [PATCH 09/22] regulator: Change db8500-prcmu match names to
 reflect Device Tree
In-Reply-To: <4FD5D49C.6070106@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-10-git-send-email-lee.jones@linaro.org>
 <4FCDDE58.5010501@linaro.org>
 <20120605102900.GP23408@opensource.wolfsonmicro.com>
 <4FCDE0A4.8070107@linaro.org>
 <20120605104201.GR23408@opensource.wolfsonmicro.com>
 <4FD5D49C.6070106@linaro.org>
Message-ID: <20120611120820.GN11439@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 12:21:00PM +0100, Lee Jones wrote:
> On 05/06/12 11:42, Mark Brown wrote:
> >On Tue, Jun 05, 2012 at 11:34:12AM +0100, Lee Jones wrote:

> >>Well without it all regulator requests from DT will fail.

> >Oh, ffs.  Why wasn't this mentioned when the patch was posted,

> I did. My 00 patch mentioned that these were all clean-ups/bug fixes
> destined for the for RCs.

You didn't CC me on that as far as I can tell so I never saw it, and
even if you had it's rather burying the lead with a large series of what
mostly looks like random cleanups from the bits I see in my archive.  I
think I assumed another patch in the series changed the names in the
device tree or added the device tree.

> Nevertheless, these two patches are required for a decent boot.

Fail.  Well, I guess I'll end up dulplicating the commits :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120611/99cf29ce/attachment.sig>
