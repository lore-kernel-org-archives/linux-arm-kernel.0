From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Apr 2015 15:20:34 +0100
Subject: [PATCH 07/14] media: omap3isp: remove unused clkdev
In-Reply-To: <36620233.VbNiGUfDRt@avalon>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye59O-0001BJ-Gq@rmk-PC.arm.linux.org.uk>
 <36620233.VbNiGUfDRt@avalon>
Message-ID: <20150405142034.GG4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 12:44:35AM +0300, Laurent Pinchart wrote:
> Hi Russell,
> 
> Thank you for the patch;
> 
> On Friday 03 April 2015 18:12:58 Russell King wrote:
> > No merged platform supplies xclks via platform data.  As we want to
> > slightly change the clkdev interface, rather than fixing this unused
> > code, remove it instead.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> with one caveat though : it conflicts with patches queued for v4.1 in the 
> media tree. I'll post a rebased version in a reply to your e-mail. How would 
> you like to handle the conflict ?

How bad is the conflict?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
