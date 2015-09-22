From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 22 Sep 2015 07:59:50 -0700
Subject: [PATCH] net: ll_temac: Use of_property_read_u32 instead of
 open-coding it
In-Reply-To: <1442922117-18420-1-git-send-email-tklauser@distanz.ch>
References: <1442922117-18420-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20150922145950.GC31436@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-22 at 01:41PM +0200, Tobias Klauser wrote:
> Use of_property_read_u32 to read the "clock-frequency" property instead
> of using of_get_property with return value checks.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
