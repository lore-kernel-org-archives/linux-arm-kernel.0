From: peter@korsgaard.com (Peter Korsgaard)
Date: Fri, 04 Oct 2013 17:24:39 +0200
Subject: [PATCH 1/2] net: ethernet: cpsw: Search childs for slave nodes
In-Reply-To: <1380890680-30941-1-git-send-email-mpa@pengutronix.de> (Markus
 Pargmann's message of "Fri, 4 Oct 2013 14:44:39 +0200")
References: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
Message-ID: <87ob75jbyg.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Markus" == Markus Pargmann <mpa@pengutronix.de> writes:

 Markus> The current implementation searches the whole DT for nodes named
 Markus> "slave".

 Markus> This patch changes it to search only child nodes for slaves.

 Markus> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
