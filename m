From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 17 Nov 2015 10:34:07 -0800
Subject: [PATCH 1/7] phy: brcmstb-sata: add missing of_node_put
In-Reply-To: <20151117183036.GF8456@google.com>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
 <20151117013830.GV8456@google.com>
 <alpine.DEB.2.02.1511170711340.2045@localhost6.localdomain6>
 <20151117174430.GA8456@google.com>
 <alpine.DEB.2.10.1511171846120.2455@hadrien>
 <20151117183036.GF8456@google.com>
Message-ID: <20151117183407.GG8456@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 10:30:36AM -0800, Brian Norris wrote:
> I expect the same sort of problem shows up plenty of other places. I
> don't think many people use CONFIG_OF_DYNAMIC, so the effects of these
> failures probably aren't felt by many.

Also, there's a quite-relevant todo item in
Documentation/devicetree/todo.txt:

=== CONFIG_OF_DYNAMIC ===
...
- Document node lifecycle for CONFIG_OF_DYNAMIC

:)

Brian
