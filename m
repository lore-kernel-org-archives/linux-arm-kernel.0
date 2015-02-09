From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 9 Feb 2015 08:15:59 -0800
Subject: [PATCH v2] i2c: cadence: fixup of wait_for_completion_timeout
 return handling
In-Reply-To: <1423494232-24747-1-git-send-email-hofrat@osadl.org>
References: <1423494232-24747-1-git-send-email-hofrat@osadl.org>
Message-ID: <0031e482e8bd435b92a52cb3ef66e56e@BY2FFO11FD025.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-02-09 at 10:03AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. The
> return variable is renamed to reflect its use and the type adjusted to
> unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	Soren
