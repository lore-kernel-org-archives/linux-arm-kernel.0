From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Nov 2009 16:37:02 +0000
Subject: ARM926 Software reset problems
In-Reply-To: <B4B24B30208E45CE8347F29D228A3C82@teltronic.es>
References: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
	<20091113122045.GA29008@n2100.arm.linux.org.uk>
	<8EBD063210E546E0BD6C80E8EF3AAD6B@teltronic.es>
	<200911131559.51887.dk-arm-linux@gmx.de>
	<B4B24B30208E45CE8347F29D228A3C82@teltronic.es>
Message-ID: <20091113163702.GB31012@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 05:31:44PM +0100, Ricardo Mart?nez wrote:
> Russell: now it works, thank you very much. But ... it is still under test
> because it sometimes hangs. For example, if I "flashcp" and overwrite
> "uImage" and then reboot, it usually hangs. And upgrading kernel image is
> something needed (not really often, of course) by my application.

Does flashcp leave the flash in status-read mode?  Does flashcp use
the mtd devices to access the flash?
