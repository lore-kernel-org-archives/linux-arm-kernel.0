From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Sep 2014 12:05:37 +0200
Subject: [PATCH 3/3] ARM: sun7i: cubieboard2: Enable the AXP209
In-Reply-To: <1411243596-15117-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411243596-15117-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140925100537.GB15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 10:06:36PM +0200, Maxime Ripard wrote:
> Add the AXP209 PMIC with the regulators in use on the cubie2.
> 
> The RTC regulator can be disabled, but since the RTC driver doesn't grab the
> regulator for now, the driver wouldn't work anymore.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Queued this one for 3.19.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/d58f5c39/attachment.sig>
