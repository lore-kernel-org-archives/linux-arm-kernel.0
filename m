From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 3 Apr 2012 10:11:52 -0400 (EDT)
Subject: [PATCH v2 06/13] USB: ohci-at91: change maximum number of ports
In-Reply-To: <80824c8cde04604acd313b93205260b2ad082a4b.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1204030954590.1537-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Apr 2012, Nicolas Ferre wrote:

> Change number of ports to 3 for newer SoCs. Modify pdata structure
> and ohci-at91 code that was dealing with ports information and check
> of port indexes.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Did you run this patch through scripts/checkpatch.pl?  I have the 
feeling that it might complain about some of the changes.

Alan Stern
