From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Feb 2013 12:41:20 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <51102E25.8040107@ti.com>
References: <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi> <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
 <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
 <20130204203358.GX4720@opensource.wolfsonmicro.com>
 <CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
 <51102E25.8040107@ti.com>
Message-ID: <20130205124120.GC17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 04:54:45PM -0500, Cyril Chemparathy wrote:
> You're assuming that cookies complete in order.  That is not necessarily  
> true.

Under what circumstances is that not true?
