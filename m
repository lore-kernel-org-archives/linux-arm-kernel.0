From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Oct 2013 09:31:20 +0800
Subject: [PATCH 02/12] usb: phy-mxs: Enable IC fixes for mx6 SoC serial
In-Reply-To: <201310121138.16584.marex@denx.de>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-3-git-send-email-peter.chen@freescale.com>
 <201310121138.16584.marex@denx.de>
Message-ID: <20131014013119.GB3879@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 11:38:16AM +0200, Marek Vasut wrote:
> Hi,
> 
> > After adding IC fixes bits, some PHY bugs are fixed by
> > IC logic.
> 
> Can you please elaborate what those bits do exactly ? They seem like a magic 
> stuff to me thus far, which is not exactly helpful . I can't find them in the 
> datasheet either.
> 

Yes, these bits are added at late TO verion for i.mx 6, and these TO versions
will be for mass production, unfortunately, the related doc update may be 
forgotten.

These two bits are related to two PHY bugs, two PHY bugs are still existed
at mx28 and mx23, one bug is fixed at mx6dq and mx6dl, and both of two
bugs are fixed at later mx6 (like mx6sololite and later SoCs), but the IC
fixes are not enabled by default, it needs software opens it.

-- 

Best Regards,
Peter Chen
