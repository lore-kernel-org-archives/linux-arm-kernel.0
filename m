From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Feb 2016 11:32:25 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <op.ydcptvss2s3iss@ecaz>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
 <20160224184114.GB2292@1wt.eu> <op.ydcptvss2s3iss@ecaz>
Message-ID: <20160225113225.036d1d5f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Imre Kaloz,

On Wed, 24 Feb 2016 20:02:09 +0100, Imre Kaloz wrote:

> Shouldn't this change be device specific then instead of messing up the  
> dtsi?

It's the order in which the nodes are defined at the top-most level
that counts. So if you change the order of the nodes in the .dts files,
it won't change anything.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
