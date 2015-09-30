From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Sep 2015 11:28:40 -0700
Subject: [PATCH 1/2] mtd: nand: sunxi: rework macros
In-Reply-To: <1442389597-30698-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442389597-30698-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150930182840.GG143959@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 09:46:36AM +0200, Boris Brezillon wrote:
> Suffix mask macros with _MSK and add new helper macros to avoid manually
> shifting values.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Pushed patch 1 to l2-mtd.git
