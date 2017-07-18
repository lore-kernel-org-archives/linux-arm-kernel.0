From: davem@davemloft.net (David Miller)
Date: Tue, 18 Jul 2017 14:51:46 -0700 (PDT)
Subject: [PATCH] net: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-39-robh@kernel.org>
References: <20170718214339.7774-39-robh@kernel.org>
Message-ID: <20170718.145146.1983238254018568174.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Jul 2017 16:43:19 -0500

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
