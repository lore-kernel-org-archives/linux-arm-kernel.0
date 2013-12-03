From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 03 Dec 2013 14:51:13 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <5298AA23.7080404@st.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
Message-ID: <1386082273.18201.61.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-29 at 14:52 +0000, Angus Clark wrote:
> 
> As I see it, the main problem with the current support is that dedicated Serial
> Flash Controllers require a level of semantics that cannot be conveyed over the
> generic SPI framework.  With this in mind, I would start by defining something
> along the lines of a "Serial Flash transfer".  

I think this is the best way to describe the issue, and approach the
solution.

We should be looking to extend the generic SPI framework to support what
we need, rather than hacking around it purely on the MTD side.

As such, I'd be very interested in Mark's thoughts on it...

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/2ad55abe/attachment.bin>
