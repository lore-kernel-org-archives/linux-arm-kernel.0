From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Nov 2015 11:54:34 -0600
Subject: [PATCH 0/2] arm: beaglex15: fix USB Gadget
In-Reply-To: <1447350781-20649-1-git-send-email-balbi@ti.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
Message-ID: <87k2pnqf1h.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Felipe Balbi <balbi@ti.com> writes:
> Hi,
>
> with the following patches I can get USB Gadget working
> with my beagle x15 with today's Linus' tree.
>
> regards
>
> Felipe Balbi (2):
>   arm: boot: dts: beaglex15: Remove ID GPIO
>   arm: boot: beaglex15: pass correct interrupt

actually, one patch missing. Didn't generate it with format-patch. I'll
send as a reply to this thread.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151112/5fcb99a2/attachment-0001.sig>
