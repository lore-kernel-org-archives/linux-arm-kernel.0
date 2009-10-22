From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 22 Oct 2009 08:34:34 +0200
Subject: [PATCH] ARM: pxafb: Use the passed fb_var_screeninfo struct in
	pxafb_pan_display()
Message-ID: <20091022063434.GQ14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

this one has been living in our kernel tree for quite some time now but
it seems it hasn't been merged yet. It's needed to make the pxafb driver
work with DirectFB applications properly.

Thanks,
Daniel
