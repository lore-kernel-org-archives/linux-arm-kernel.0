From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Jul 2013 15:41:19 +0200
Subject: NSA310 + DT
In-Reply-To: <2544f179ed4349545a25aa60d52a664a@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <20130709202143.GD26223@lunn.ch>
 <2544f179ed4349545a25aa60d52a664a@harsszegi.com>
Message-ID: <20130710134119.GA30885@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tibor

I created a DTS file based on the tree you gave me.

Please could you try

https://github.com/lunn/linux.git branch v3.10-nsa310-tdc

and the DTS file arch/arm/boot/dts/kirkwood-nsa310-tdc.dts

Please use 

make kirkwood_defconfig
make

and it should have the lm85 built in.

The two different NSA310 are mostly similar, just a few different gpio
LEDs and buttons, so i might actually refactor the two dts files with
what is shared. But lets get your box working first.

     Andrew
