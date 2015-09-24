From: davem@davemloft.net (David Miller)
Date: Thu, 24 Sep 2015 14:30:26 -0700 (PDT)
Subject: [PATCH] net: axinet: Use of_property_read_u32 instead of
 open-coding it
In-Reply-To: <1442922357-18815-1-git-send-email-tklauser@distanz.ch>
References: <1442922357-18815-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20150924.143026.2079628172995483094.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tobias Klauser <tklauser@distanz.ch>
Date: Tue, 22 Sep 2015 13:45:57 +0200

> Use of_property_read_u32 instead of of_get_property with return value
> checks and endianness conversion.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to net-next.
