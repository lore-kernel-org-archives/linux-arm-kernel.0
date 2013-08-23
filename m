From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 19:17:05 +0200
Subject: [PATCH v4 3/5] net: ethernet: cpsw: introduce ti,am3352-cpsw
 compatible string
In-Reply-To: <5217974B.5090503@ti.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-4-git-send-email-zonque@gmail.com>
 <52177052.1030308@ti.com> <52178E20.5040404@gmail.com>
 <52179448.1020906@ti.com> <5217974B.5090503@ti.com>
Message-ID: <52179911.9030705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.08.2013 19:09, Sekhar Nori wrote:
> On 8/23/2013 10:26 PM, Santosh Shilimkar wrote:

>> So just stick the IP version or call it cpsw-v1... cpsw-v2 etc.
> 
> If this could be handled using IP version then the right way would be to
> just read the IP version from hardware and use it. No need of DT property.

Yes, exactly. The information we need to support the phy interface
setting is completely disconnected from the cpsw core itself.


Daniel
