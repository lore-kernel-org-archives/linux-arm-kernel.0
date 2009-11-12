From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 12 Nov 2009 21:06:31 +0000
Subject: [PATCH v3 2/4] Add support for LZO-compressed kernels for ARM
In-Reply-To: <1257942478-18719-3-git-send-email-albin.tonnerre@free-electrons.com>
References: <1257942478-18719-1-git-send-email-albin.tonnerre@free-electrons.com>
	<1257942478-18719-2-git-send-email-albin.tonnerre@free-electrons.com>
	<1257942478-18719-3-git-send-email-albin.tonnerre@free-electrons.com>
Message-ID: <20091112210631.GA29311@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Albin Tonnerre <albin.tonnerre@free-electrons.com> [2009-11-11 13:27]:
> This is the second part of patch. This part includes:
>  - changes to ach/arch/boot/Makefile to make it easier to add new
>    compression types
>  - changes in arch/arm/boot/compressed/misc.c to allow the use of lzo or
>    gzip, depending on the config

I tested your arm patch together with your unsubmitted patch to allow
lzma and it works great!  Thanks a lot for working on this.  Feel free
to add my:

Tested-by: Martin Michlmayr <tbm@cyrius.com>

I tested lzma compressed kernels on the following ARM machines:
 - Linksys NSLU2 (ixp4xx)
 - SheevaPlug (kirkwood)
 - QNAP TS-219 (kirkwood)
 - Thecus N2100 (iop32x)

-- 
Martin Michlmayr
http://www.cyrius.com/
