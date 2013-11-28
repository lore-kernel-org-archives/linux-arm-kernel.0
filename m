From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 28 Nov 2013 18:14:38 +0100
Subject: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <52977954.20006@cogentembedded.com>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127110413.GA2603@katana> <52977954.20006@cogentembedded.com>
Message-ID: <4401360.Outsal0mcb@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 November 2013 21:11:48 Sergei Shtylyov wrote:
> On 27-11-2013 15:04, Wolfram Sang wrote:
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		eeprom: 24c128 at 50 {
> >> +			compatible = "at,24c128";
> > 
> > Minor nit: Should be a vendor name, not the name of the driver
> 
> Moreover, the node should be named generically, like "flash at 50", not
> "24c128 at 50".

Or, given that it's an eeprom, "eeprom at 50" ? :-)

-- 
Regards,

Laurent Pinchart
