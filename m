From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Feb 2018 14:13:06 -0600
Subject: [PATCH 09/11] DT: arm: shmobile: document Condor board bindings
In-Reply-To: <30a4e575-a2c9-e0d3-f41f-4e9b15543365@cogentembedded.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
 <30a4e575-a2c9-e0d3-f41f-4e9b15543365@cogentembedded.com>
Message-ID: <20180208201306.peirumr6hvu22uyt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 09:45:08PM +0300, Sergei Shtylyov wrote:
> Document the Condor device tree bindings, listing it as a supported board.
> 
> This allows to use checkpatch.pl to validate .dts files referring to the
> Condor board.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
