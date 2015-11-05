From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Nov 2015 08:07:19 -0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <1446709737-11316-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1446709737-11316-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151105160719.GG6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 05, 2015 at 08:48:57AM +0100, LABBE Corentin wrote:
> sun4i-ss implementaton of md5/sha1 is via ahash algorithms.
> A recent change make impossible to load them without giving statesize.

Which one?

> This patch specifiy statesize for sha1 and md5.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> Cc: stable at vger.kernel.org

Please also add a Fixes tag (and the stable version it applies to).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151105/ae805bb8/attachment.sig>
