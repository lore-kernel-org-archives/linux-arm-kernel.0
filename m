From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Jun 2014 08:16:38 -0500
Subject: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20140617131638.GA9070@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 11:37:13AM +0300, Tomi Valkeinen wrote:
> From: Sathya Prakash M R <sathyap@ti.com>
> 
> Add DSS hwmod data for AM43xx.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> [tomi.valkeinen at ti.com: added missing dispc flags]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Acked-by: Rajendra Nayak <rnayak@ti.com>

tested on top of today's linux-next
(5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk. Works fine:

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: minicom.cap
Type: application/vnd.tcpdump.pcap
Size: 30529 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/2b6f8009/attachment-0001.cap>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/2b6f8009/attachment-0001.sig>
