From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 May 2012 14:04:56 +0100
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <4FC768F8.4050406@ti.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
 <4FC768F8.4050406@ti.com>
Message-ID: <20120531130456.GB15786@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 02:50:00PM +0200, Cousson, Benoit wrote:

> Now the question is should we extend the Linux device structure to
> handle such HW IP, or should we extend the clock definition to
> handle this kind of extended clock node.

> It looks to me that this kind of function does belong to the device
> more than to the clock node.

This is looking a lot like what power domains do to me...
