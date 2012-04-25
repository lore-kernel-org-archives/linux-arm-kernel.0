From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Apr 2012 09:14:18 +0200
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20375.40225.227084.644318@ipc1.ka-ro>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424201802.GE3628@n2100.arm.linux.org.uk>
 <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
 <20120425052802.GF13489@lunn.ch>
 <20375.40225.227084.644318@ipc1.ka-ro>
Message-ID: <20120425071418.GA2116@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> AFAICT the PCI archs do not have HAVE_CLK enabled. Thus they will have
> a dummy clk API in place that provides the driver with a non-error
> clk_get() return value.
 
Hi Lothar

Please could you explain this a little bit more. What exactly is a PCI
arch?

Most of the Orion SoC have PCIe busses. Does this make them an PCI
arch? Because they also have HAVE_CLK. There are more SoCs with PCI.

      Thanks
	Andrew
