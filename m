From: davem@davemloft.net (David Miller)
Date: Thu, 24 Sep 2015 14:30:20 -0700 (PDT)
Subject: [PATCH] net: ll_temac: Use of_property_read_u32 instead of
 open-coding it
In-Reply-To: <1442922117-18420-1-git-send-email-tklauser@distanz.ch>
References: <1442922117-18420-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20150924.143020.1888677133468835413.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tobias Klauser <tklauser@distanz.ch>
Date: Tue, 22 Sep 2015 13:41:57 +0200

> Use of_property_read_u32 to read the "clock-frequency" property instead
> of using of_get_property with return value checks.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to net-next.
