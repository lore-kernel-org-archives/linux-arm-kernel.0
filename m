From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 16 Jan 2014 19:19:46 +0400
Subject: [PATCH v6 net-next 1/4] sh_eth: Use bool as return type of
 sh_eth_is_gether()
In-Reply-To: <1389839656-10932-2-git-send-email-horms+renesas@verge.net.au>
References: <1389839656-10932-1-git-send-email-horms+renesas@verge.net.au>
 <1389839656-10932-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <52D7F892.1050708@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-01-2014 6:34, Simon Horman wrote:

> Return a boolean and use true and false.

    You're not using them explicitly anymore. I'd update the changelog
with converting the function to one-liner.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

WBR, Sergei
