From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 22 Sep 2015 09:03:33 -0700
Subject: [PATCH] net: axinet: Use of_property_read_u32 instead of
 open-coding it
In-Reply-To: <1442922357-18815-1-git-send-email-tklauser@distanz.ch>
References: <1442922357-18815-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20150922160333.GD31436@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-22 at 01:45PM +0200, Tobias Klauser wrote:
> Use of_property_read_u32 instead of of_get_property with return value
> checks and endianness conversion.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
