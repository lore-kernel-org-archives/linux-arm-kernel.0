From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Jun 2016 21:48:47 -0500
Subject: [PATCH v4 1/7] mfd: ac100: Add device tree bindings for X-Powers
 AC100 codec/RTC combo IC
In-Reply-To: <1467302331-9663-2-git-send-email-wens@csie.org>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
 <1467302331-9663-2-git-send-email-wens@csie.org>
Message-ID: <20160701024847.GA1444@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 11:58:45PM +0800, Chen-Yu Tsai wrote:
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v3:
> 
>   - Fixed device node names and added labels.
>   - Added clock output from codec and input to rtc.
> 
> Changes since v2:
> 
>   - Fix interrupt line for ac100_codec in provided example.
> 
> ---
>  Documentation/devicetree/bindings/mfd/ac100.txt | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt

Acked-by: Rob Herring <robh@kernel.org>
