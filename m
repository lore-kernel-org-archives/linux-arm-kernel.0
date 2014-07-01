From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 15:48:44 +0100
Subject: [PATCH CFT 12/30] net: fec: ensure fec_enet_free_buffers()
 properly cleans the rings
In-Reply-To: <53ADBC8A.8070103@cogentembedded.com>
References: <20140627151542.GL32514@n2100.arm.linux.org.uk>
 <E1X0XwQ-0001Na-Kg@rmk-PC.arm.linux.org.uk>
 <53ADBC8A.8070103@cogentembedded.com>
Message-ID: <20140701144843.GW32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 10:48:42PM +0400, Sergei Shtylyov wrote:
>    dev_kfree_skb() (actually, consume_skb() that it calls) already checks 
> 'skb' for NULL.

This patch has now been updated for that, thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
