From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 20 May 2013 19:11:22 +0200
Subject: [PATCH 30/33] arch/arm/plat-samsung: don't check resource with
 devm_ioremap_resource
In-Reply-To: <519A517F.5020003@samsung.com>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
 <1368702961-4325-31-git-send-email-wsa@the-dreams.de>
 <519A517F.5020003@samsung.com>
Message-ID: <20130520171118.GA5717@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 01:38:23AM +0900, Kukjin Kim wrote:
> On 05/16/13 20:15, Wolfram Sang wrote:
> >devm_ioremap_resource does sanity checks on the given resource. No need to
> >duplicate this in the driver.
> >
> >Signed-off-by: Wolfram Sang<wsa@the-dreams.de>
> 
> Looks good to me, applied into Samsung tree.
> 
> Wolfram, if you want to take this into your tree, let me know.

It is already upstream :)
