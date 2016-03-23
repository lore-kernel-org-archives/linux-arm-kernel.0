From: david@lechnology.com (David Lechner)
Date: Wed, 23 Mar 2016 13:32:27 -0500
Subject: [PATCH v2 03/11] ARM: davinci: da850: use clk->set_parent for
 async3
In-Reply-To: <56F2D27F.6040001@ti.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-4-git-send-email-david@lechnology.com>
 <56F2BCAB.3040404@ti.com> <56F2D05C.8030909@lechnology.com>
 <56F2D27F.6040001@ti.com>
Message-ID: <56F2E13B.4000407@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 12:29 PM, Sekhar Nori wrote:
>
> Alright, I guess 'can be called' in the comment should have used
> stronger language :) How about late registration of USB clocks as I
> suggested. It should also help consolidate code across da830 and da850.
>

What about the new async3 clock? It will require later registration too, 
but it has many children that depend on it.
