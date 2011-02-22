From: yujinzhi123@gmail.com (=?GB2312?B?0+C999bH?=)
Date: Tue, 22 Feb 2011 22:00:16 +0800
Subject: SAMSUNG: any example code for soc_camera, tv output, etc...?
In-Reply-To: <9f2nkr$9lh756@out1.ip04ir2.opaltelecom.net>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk>
	<017901cbce9b$7b405ee0$71c11ca0$%kim@samsung.com>
	<20110217140621.GC24989@n2100.arm.linux.org.uk>
	<01b001cbcef7$3e7f5f90$bb7e1eb0$%kim@samsung.com>
	<9f2nkr$9lh756@out1.ip04ir2.opaltelecom.net>
Message-ID: <AANLkTin0PR3VQLruade+w6GbCMoW9pXy4Kvn-sBZ+LBM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've just gone through a lot of Samsung platform setup files in arch/arm/ , but >haven't yet found any Samsung-SoC-based boards pre-plumbed into V4L2, nor >any that connect up to a TV out (rather than to an LCD screen).

I have port a embeded linux system on my board based on EP9315, with
support for usb video capture device, V4L2. Do you need V4L2 based on
usb video capture device or other video/FM/AM controller on your
board? If conveniently, can you provide more details about your
project?

>Alternatively, please say if you know which specific file(s) I should be asking >Samsung tech support for under NDA (via my distributor's tech support).

You MUST need the datasheet of S5PC100 on your board, and other
peripheral device's datasheet, like dm9000 ethernet controller if not
integrated in SoC, and schematic diagrams of your board.
