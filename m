From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 15 Jan 2017 12:08:31 +0100
Subject: [PATCH net-next v3 00/10] net: dsa: Support for pdata in dsa2
In-Reply-To: <20170114214713.28109-1-f.fainelli@gmail.com>
References: <20170114214713.28109-1-f.fainelli@gmail.com>
Message-ID: <20170115110831.GH26374@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 01:47:03PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This is not exactly new, and was sent before, although back then, I did not
> have an user of the pre-declared MDIO board information, but now we do. Note
> that I have additional changes queued up to have b53 register platform data for
> MIPS bcm47xx and bcm63xx.
> 
> Yes I know that we should have the Orion platforms eventually be converted to
> Device Tree, but until that happens, I don't want any remaining users of the
> old "dsa" platform device (hence the previous DTS submissions for ARM/mvebu)
> and, there will be platforms out there that most likely won't never see DT
> coming their way (BCM47xx is almost 100% sure, BCM63xx maybe not in a distant
> future).
> 
> We would probably want the whole series to be merged via David Miller's tree
> to simplify things.
> 
> Greg, can you Ack/Nack patch 5 since it touched the core LDD?

I've NAKed them for now, you need to describe what you are trying to do
here, as it doesn't make any sense to me at the moment.

thanks,

greg k-h
