From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 19 Nov 2012 07:51:37 +0100
Subject: [PATCH 1/2] Fix build error in pwm-vt8500.c
In-Reply-To: <1353290780-19413-2-git-send-email-linux@prisktech.co.nz>
References: <1353290780-19413-1-git-send-email-linux@prisktech.co.nz>
 <1353290780-19413-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121119065137.GC21890@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 03:06:19PM +1300, Tony Prisk wrote:
> A missing '{' causes a build error in pwm-vt8500.c

Great, how embarrassing. You've just uncovered a typo in my automated
build test setup. =)

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/d8fdd974/attachment-0001.sig>
