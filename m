From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 6 Oct 2014 08:03:47 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <2257006.dpJJ6zLgnP@avalon>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon>
Message-ID: <20141006060347.GB1266@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >   - While the serial console on r8a7790 was switched from SCIF0 to
> >     SCIFA0 recently, I believe r8a7990 still needs to use SCIF0 instead
> >     of SCIFA0, as that's what the bootloader has configured.
> 
> Good point. Wolfram, any opinion about this ?

IMO we should only use SCIFA if it uses the same wires as SCIF. This
is the case for Lager (7790). Dunno about other boards.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/7c2abe52/attachment.sig>
