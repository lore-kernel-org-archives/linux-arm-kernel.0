From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Apr 2015 23:45:47 +0200
Subject: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <20150411214005.GJ5244@lunn.ch>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
 <1428784160-19431-3-git-send-email-andrew@ncrmnt.org>
 <20150411214005.GJ5244@lunn.ch>
Message-ID: <20150411214547.GK5244@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +		internal-regs {
> > +			serial at 12000 {
> > +				status = "okay";
> > +			};
> > +
> > +			serial at 12100 {
> > +				status = "okay";
> > +			};
> 
> Are both serial ports usable?

Ah, sorry. I now noticed you said the MCU is on uart1.
Could you add a comment here please.

      Andrew
