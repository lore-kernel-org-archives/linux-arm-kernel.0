From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Apr 2016 13:54:31 +0200
Subject: [PATCH v5 2/2] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <20160412063802.GA23438@tiger>
References: <1459806792-7729-1-git-send-email-andrew@lunn.ch>
 <1459806792-7729-3-git-send-email-andrew@lunn.ch>
 <20160412063802.GA23438@tiger>
Message-ID: <20160412115431.GA29895@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 02:38:02PM +0800, Shawn Guo wrote:
> On Mon, Apr 04, 2016 at 11:53:12PM +0200, Andrew Lunn wrote:
> > +&iomuxc {
> 
> We usually put iomuxc node at the end of the file to make the file a bit
> easier for reading.

Hi Shawn

You asked me to sort the nodes, so i did.
 
> All above comments are trivial, so I decided to fix them up and apply
> the patch.

Great, thanks.

Any comments on the serial port issue? Quirk vs module parameter?

Thanks
	Andrew
