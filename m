From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Feb 2016 13:36:51 -0600
Subject: [PATCH v11 08/10] dt, numa: Add NUMA dt binding implementation.
In-Reply-To: <1455930799-5371-9-git-send-email-ddaney.cavm@gmail.com>
References: <1455930799-5371-1-git-send-email-ddaney.cavm@gmail.com>
 <1455930799-5371-9-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160223193651.GA8491@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 05:13:17PM -0800, David Daney wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> ADD device tree node parsing for NUMA topology using device
> "numa-node-id" property distance-map.

I still want an adequate explanation why NUMA setup cannot be done with 
an unflattened tree. PowerPC manages to do that and should have a 
similar init flow being memblock based, so I would expect arm64 can too.

Rob
