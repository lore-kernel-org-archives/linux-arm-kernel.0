From: davem@davemloft.net (David Miller)
Date: Thu, 06 Oct 2016 20:41:44 -0400 (EDT)
Subject: [PATCH] net: axienet: Add missing \n to end of dev_err messages
In-Reply-To: <20161004111141.11768-1-colin.king@canonical.com>
References: <20161004111141.11768-1-colin.king@canonical.com>
Message-ID: <20161006.204144.935332920047409761.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin King <colin.king@canonical.com>
Date: Tue,  4 Oct 2016 12:11:41 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_err messages are missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
