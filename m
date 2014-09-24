From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Sep 2014 08:32:08 +0200
Subject: [PATCH 2/3] mfd: axp209x: Drop the parent supplies field
In-Reply-To: <1411243596-15117-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411243596-15117-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140924063207.GP15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Sat, Sep 20, 2014 at 10:06:35PM +0200, Maxime Ripard wrote:
> Now that the regulator code get its parent supplies purely from the DT, we can
> drop the parent supplies resources in the MFD driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

I know you have given your acked-by already, but could you merge this
patch through your tree?

It doesn't have any depedency, so it should be rather safe to do so.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/eb60c0e2/attachment.sig>
