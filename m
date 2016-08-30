From: eric@anholt.net (Eric Anholt)
Date: Tue, 30 Aug 2016 11:26:05 -0700
Subject: [PATCH] char: hw_random: bcm2835: handle of_iomap failures in
 bcm2835 driver
In-Reply-To: <1472490616-9597-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1472490616-9597-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <87bn0aazb6.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> Check return value of of_iomap and handle errors correctly.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160830/8cc1fefe/attachment.sig>
