From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 7 Aug 2015 10:28:14 +0800
Subject: [PATCH v3 5/8] ARM: mediatek: add smp bringup code for MT6580
In-Reply-To: <20150805094429.GU7557@n2100.arm.linux.org.uk>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
 <1438696464-59858-6-git-send-email-scott.shu@mediatek.com>
 <20150805094429.GU7557@n2100.arm.linux.org.uk>
Message-ID: <1438914494.1900.38.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-05 at 10:44 +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 04, 2015 at 09:54:21PM +0800, Scott Shu wrote:
> > Add support for cpu enable-method "mediatek,mt6580-smp" for booting
> > secondary CPUs on MT6580.
> 
> If you have CPU power domain support, and you power up and power down the
> CPUs, why do you need the boot_lock and pen_release stuff?  Isn't keeping
> the power off on a CPU sufficient to prevent it entering the kernel?
> 
Thanks Russell. Yes, the system works well after removing boot_lock and
pen_release. Will be fixed in next version. 

Scott
