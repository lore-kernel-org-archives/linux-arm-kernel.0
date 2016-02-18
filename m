From: davem@davemloft.net (David Miller)
Date: Thu, 18 Feb 2016 11:05:14 -0500 (EST)
Subject: [PATCH 2/2] net, thunderx: Use bool in structs where possible
In-Reply-To: <1455799149-19590-3-git-send-email-rrichter@caviumnetworks.com>
References: <1455799149-19590-1-git-send-email-rrichter@caviumnetworks.com>
 <1455799149-19590-3-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <20160218.110514.652169911099659792.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@caviumnetworks.com>
Date: Thu, 18 Feb 2016 13:39:09 +0100

> From: Robert Richter <rrichter@cavium.com>
> 
> Looks like the :1 notation was accidentally introduced (this still
> uses 1 byte per flag). Using bool instead, which is the common use.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Such cleanups are not appropriate for 'net'.  Only real bug fixes should
be targetted that.

Respin these patches targetting the correct tree(s).
