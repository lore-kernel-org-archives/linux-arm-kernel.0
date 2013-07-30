From: nm@ti.com (Nishanth Menon)
Date: Tue, 30 Jul 2013 14:58:02 -0500
Subject: [PATCHv4 17/33] CLK: DT: add support for set-rate-parent flag
In-Reply-To: <1374564028-11352-18-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-18-git-send-email-t-kristo@ti.com>
Message-ID: <51F81ACA.7090501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> Adding set-rate-parent to clock node now allows a node to forward
> clk_set_rate request to its parent clock.

Apologies about previous comment of set-parent missing, the sequence of 
patches messed with me :(. had expected generic clk changes at the start 
of the series followed by the rest.

>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   drivers/clk/clk-divider.c      |    6 +++++-
>   drivers/clk/clk-fixed-factor.c |    6 +++++-
>   drivers/clk/clk-gate.c         |    8 ++++++--
>   drivers/clk/clk-mux.c          |    6 +++++-
>   4 files changed, 21 insertions(+), 5 deletions(-)

Documentation/devicetree/bindings/clock/ needs update as well.
[...]

-- 
Regards,
Nishanth Menon
