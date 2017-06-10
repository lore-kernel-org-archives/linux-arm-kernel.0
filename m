From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Sat, 10 Jun 2017 12:33:38 -0700
Subject: [PATCH v2 1/3] dt-bindings: remoteproc: Add Keystone DSP
 remoteproc binding
In-Reply-To: <20170608002447.47580-2-s-anna@ti.com>
References: <20170608002447.47580-1-s-anna@ti.com>
 <20170608002447.47580-2-s-anna@ti.com>
Message-ID: <3a4d0c88-6077-1c59-8559-d3db3de914f4@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/7/2017 5:24 PM, Suman Anna wrote:
> Add the device tree bindings document for the Texas Instrument's
> Keystone 2 DSP remoteproc devices.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Sam Nelson <sam.nelson@ti.com>
> ---
> v2 Changes:
>   - Modified the patch title
>   - Dropped unstable binding status
>   - Dropped the 'label' property and replaced the device node description
>     to use an alias
>   - Renamed 'kick-gpio' to 'kick-gpios'
>   - Updated the example

Looks reasonable to me. Ofcourse you need Rob's ack for this one.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
