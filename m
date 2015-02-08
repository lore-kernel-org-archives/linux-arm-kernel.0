From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 8 Feb 2015 08:50:18 -0800
Subject: [PATCH] i2c: cadence: match return type of
 wait_for_completion_timeout
In-Reply-To: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
References: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150208165018.GH9214@xsjandreislx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-02-08 at 07:55AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> ret is only used for wait_for_completion_timeout anyway the type is simply 
> changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
