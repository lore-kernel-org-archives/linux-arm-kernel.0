From: davem@davemloft.net (David Miller)
Date: Tue, 11 Aug 2015 11:49:08 -0700 (PDT)
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
In-Reply-To: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150811.114908.1384923604512568161.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <ddaney.cavm@gmail.com>
Date: Mon, 10 Aug 2015 17:58:35 -0700

> Change from v1:  Drop PHY binding part, use fwnode_property* APIs.
> 
> The first patch (1/2) rearranges the existing code a little with no
> functional change to get ready for the second.  The second (2/2) does
> the actual work of adding support to extract the needed information
> from the ACPI tables.

Series applied.

In the future it might be better structured to try and get the OF
node, and if that fails then try and use the ACPI method to obtain
these values.
