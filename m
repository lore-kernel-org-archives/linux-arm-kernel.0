From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Mar 2011 11:33:34 +0200
Subject: [PATCH] DM644x EVM: register MUSB device earlier
In-Reply-To: <4D7E640A.9090908@mvista.com>
References: <201103132306.59986.sshtylyov@ru.mvista.com>
	<20110314085248.GA2285@legolas.emea.dhcp.ti.com>
	<4D7E640A.9090908@mvista.com>
Message-ID: <20110315093332.GA3602@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 14, 2011 at 09:52:58PM +0300, Sergei Shtylyov wrote:
> >I wonder how noone has noticed that from -rc1 until now.
> 
>    I don't think many people run the most current DaVinci kernel.
> Most people probably use the Arago project kernels or even older
> MV-based TI's stuff...

that's nasty :-p All those hacks on a 2.6.18 kernel... Oh well, thanks
for noticing and sending a patch :-)

-- 
balbi
