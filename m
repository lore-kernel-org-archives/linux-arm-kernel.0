From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 09:48:28 +0100
Subject: [PATCH v3 1/3] nvmem: sunxi-sid: read NVMEM size from device
 compatible
In-Reply-To: <20170202131338.20234-1-icenowy@aosc.xyz>
References: <20170202131338.20234-1-icenowy@aosc.xyz>
Message-ID: <20170206084828.s33k4fg6n7mcivb2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 09:13:36PM +0800, Icenowy Zheng wrote:
> Sometimes the SID device have more memory address space than the real
> NVMEM size (for the registers used to read/write the SID).
> 
> Fetch the NVMEM size from device compatible, rather than the memory
> address space's length, in order to prepare for adding some
> registers-based read support.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/c3412e37/attachment.sig>
