From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Nov 2016 20:59:35 +0800
Subject: [PATCH RESEND 1/3] clk: imx6: Mask mmdc_ch1 handshake for
 periph2_sel and mmdc_ch1_axi_podf
In-Reply-To: <CAOMZO5BQHKv7dxJTq2C1qdvhhRRRW8bafaXoQW77AKLNTWggAg@mail.gmail.com>
References: <1476750554-21961-1-git-send-email-festevam@gmail.com>
 <CAOMZO5BQHKv7dxJTq2C1qdvhhRRRW8bafaXoQW77AKLNTWggAg@mail.gmail.com>
Message-ID: <20161101125935.GA23831@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 01:48:56PM -0200, Fabio Estevam wrote:
> Shawn,
> 
> Are you collecting the imx clk patches in this cycle?
> 
> I see no response from Stephen on this series from a long time.
> 
> We missed 4.9, so hopefully this can land in 4.10.

Okay, I just applied the series to imx/clk branch, and will get it into
linux-next for wider testing.  If no issue is reported, I will send it
to Stephen and Mike then.

Shawn
