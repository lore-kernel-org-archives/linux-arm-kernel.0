From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Apr 2016 02:16:30 -0700
Subject: [PATCH v3 01/19] clk: composite: Add unregister function
In-Reply-To: <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160410091630.GV4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Mike,

On Wed, Mar 23, 2016 at 05:38:24PM +0100, Maxime Ripard wrote:
> The composite clock didn't have any unregistration function, which forced
> us to use clk_unregister directly on it.
> 
> While it was already not great from an API point of view, it also meant
> that we were leaking the clk_composite structure allocated in
> clk_register_composite.
> 
> Add a clk_unregister_composite function to fix this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Any comment on this one ?

(and the other clock patches)

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160410/9c1e564a/attachment.sig>
