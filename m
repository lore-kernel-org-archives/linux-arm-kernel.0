From: wei.liu2@citrix.com (Wei Liu)
Date: Sat, 8 Aug 2015 14:59:04 +0100
Subject: [PATCH v3 01/20] net/xen-netback: xenvif_gop_frag_copy: move GSO
 check out of the loop
In-Reply-To: <1438966019-19322-2-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-2-git-send-email-julien.grall@citrix.com>
Message-ID: <20150808135904.GA14214@zion.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 05:46:40PM +0100, Julien Grall wrote:
> The skb doesn't change within the function. Therefore it's only
> necessary to check if we need GSO once at the beginning.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> 

Acked-by: Wei Liu <wei.liu2@citrix.com>
