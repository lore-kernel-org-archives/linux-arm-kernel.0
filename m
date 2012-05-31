From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 May 2012 12:57:23 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531094616.GP5377@arwen.pp.htv.fi>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
 <20120531092603.GM5377@arwen.pp.htv.fi>
 <20120531094301.GT8026@tbergstrom-lnx.Nvidia.com>
 <20120531094616.GP5377@arwen.pp.htv.fi>
Message-ID: <20120531095723.GU8026@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> Well, that's just because struct device doesn't know about its own clock
> providers, right ? Should that be patched too ?
> 
> Russell, as the orignal author of the clk API, what do you think ?

Even if it would know, how would that solve the problem? only the
clockframework is supposed to know about struct clk.

Cheers,

Peter.
