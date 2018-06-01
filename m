From: eric@anholt.net (Eric Anholt)
Date: Fri, 01 Jun 2018 10:09:24 -0700
Subject: [PATCH 1/6] staging: vc04_services: no need to check debugfs
 return values
In-Reply-To: <20180601111004.1670-1-gregkh@linuxfoundation.org>
References: <20180601111004.1670-1-gregkh@linuxfoundation.org>
Message-ID: <8760321liz.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Clean up the vchiq_arm code by not caring about the value of debugfs
> calls.  This ends up removing a number of lines of code that are not
> needed.

This series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks for the cleanups!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180601/d86564ed/attachment.sig>
