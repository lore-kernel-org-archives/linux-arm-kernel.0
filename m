From: eric@anholt.net (Eric Anholt)
Date: Mon, 07 Nov 2016 08:38:26 -0800
Subject: [PATCH v2] staging: vc04_services: setup DMA and coherent mask
In-Reply-To: <20161031210203.2089-1-mzoran@crowfest.net>
References: <20161031210203.2089-1-mzoran@crowfest.net>
Message-ID: <87vavzxn25.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Zoran <mzoran@crowfest.net> writes:

> VCHI messages between the CPU and firmware use 32-bit
> bus addresses. Explicitly set the DMA mask and coherent
> on all platforms.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/14619b5d/attachment.sig>
