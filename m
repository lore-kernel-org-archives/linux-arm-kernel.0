From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Jun 2013 09:19:40 +0200
Subject: [PATCHv3 01/11] irqdomain: add irq_alloc_mapping() function
In-Reply-To: <1371660979-21588-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621091940.03229521@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On Wed, 19 Jun 2013 18:56:09 +0200, Thomas Petazzoni wrote:
> This commit extends the irqdomain subsystem with an
> irq_alloc_mapping() function which allows to let the irqdomain code
> find an available hwirq number in the range [ 0 ; domain size ] for
> the given domain, and create a virq mapping for it.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Any comments? Any chance that you could take this for 3.11?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
