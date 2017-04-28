From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 08:39:23 -0500
Subject: [PATCH 1/8] [RFC] dt-bindings: renesas: Document R-Car H3 and
 M3-W SiP DT bindings
In-Reply-To: <1492593351-13835-2-git-send-email-geert+renesas@glider.be>
References: <1492593351-13835-1-git-send-email-geert+renesas@glider.be>
 <1492593351-13835-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20170428133923.ycbqixcxvcsonocn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 11:15:44AM +0200, Geert Uytterhoeven wrote:
> Document the SiP ("System-in-Package") versions of the R-Car H3 and M3-W
> SoCs, which contain an R-Car H3 or M3-W SoC, RAM, and HyperFlash.
> 
> Add their compatible values to all boards equipped with R-Car Gen3 SiPs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Questions:
>   - Do we need more compatible values, for different configurations?
>     At least r8j7796 is available with either 2 GiB or 4 GiB of RAM,
>     possibly using RAM parts from different vendors.

Same die, just a different package? If so, I don't think you need a 
different compatible. It's going to be a different board from any 
non-SiP which should be enough to distinguish.

Rob
