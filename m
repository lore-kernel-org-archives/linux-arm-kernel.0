From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 24 May 2014 08:46:58 +0200
Subject: [PATCH 1/5] phy: add support for USB cluster on the Armada 375 SoC
In-Reply-To: <537FC2BE.1040501@free-electrons.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
 <537F12F5.2030102@ti.com> <537FC2BE.1040501@free-electrons.com>
Message-ID: <20140524084658.30e307fb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory, Kishon,

On Fri, 23 May 2014 23:50:54 +0200, Gregory CLEMENT wrote:

> >> +MODULE_DESCRIPTION("Armada 375 USB cluster driver");
> >> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
> >> +MODULE_LICENSE("GPL");
> > 
> > GPL v2?
> 
> See the header, I chose "GNU General Public License version 2 or later."
> so "GPL" match it.

And also, the vast majority of kernel drivers use
MODULE_LICENSE("GPL") :

$ git grep 'MODULE_LICENSE("GPL")' | wc -l
5615
$ git grep 'MODULE_LICENSE("GPLv2")' | wc -l
5
$ git grep 'MODULE_LICENSE("GPL v2")' | wc -l
932

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
