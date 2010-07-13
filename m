From: davem@davemloft.net (David Miller)
Date: Mon, 12 Jul 2010 20:36:11 -0700 (PDT)
Subject: [PATCH] fec: use interrupt for MDIO completion indication
In-Reply-To: <006416d38a8e51ba8dd8631613a991528dc7976a.1278918594.git.baruch@tkos.co.il>
References: <006416d38a8e51ba8dd8631613a991528dc7976a.1278918594.git.baruch@tkos.co.il>
Message-ID: <20100712.203611.67894902.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baruch Siach <baruch@tkos.co.il>
Date: Mon, 12 Jul 2010 10:12:51 +0300

> With the move to phylib (commit e6b043d) I was seeing sporadic "MDIO write
> timeout" messages. Measure of the actual time spent showed latency times of
> more than 1600us.
> 
> This patch uses the MII event indication of the FEC hardware to detect
> completion of MDIO transactions.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied.
