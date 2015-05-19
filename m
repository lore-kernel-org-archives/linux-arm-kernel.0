From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 14:53:03 +0100
Subject: [Xen-devel] [RFC 07/23] net/xen-netfront: Correct printf format
 in xennet_get_responses
In-Reply-To: <1431622863-28575-8-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-8-git-send-email-julien.grall@citrix.com>
Message-ID: <555B403F.3030708@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> rx->status is an int16_t, print it using %d rather than %u in order to
> have a meaningful value when the field is negative.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
