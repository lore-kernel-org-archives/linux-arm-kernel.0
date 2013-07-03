From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 17:19:48 +0300
Subject: [PATCH v3 8/8] wlcore/wl12xx: check if we got correct clock data
 from DT
In-Reply-To: <1372860209-3504-9-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-9-git-send-email-coelho@ti.com>
Message-ID: <20130703141948.GS15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:03:29PM +0300, Luciano Coelho wrote:
> The fref and the tcxo clocks settings are optional in some platforms.
> WiLink8 doesn't need either, so we don't check the values.  WiLink 6
> only needs the fref clock, so we check that it is valid or return with
> an error.  WiLink7 needs both clocks, if either is not available we
> return with an error.
> 
> Signed-off-by: Luciano Coelho <coelho@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/e00fbc09/attachment.sig>
