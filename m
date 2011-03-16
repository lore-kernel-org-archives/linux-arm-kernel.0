From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2011 14:42:32 +0300
Subject: [PATCH] DM644x EVM: register MUSB device earlier
In-Reply-To: <20110315093332.GA3602@legolas.emea.dhcp.ti.com>
References: <201103132306.59986.sshtylyov@ru.mvista.com>
	<20110314085248.GA2285@legolas.emea.dhcp.ti.com>
	<4D7E640A.9090908@mvista.com>
	<20110315093332.GA3602@legolas.emea.dhcp.ti.com>
Message-ID: <4D80A228.7000602@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-03-2011 12:33, Felipe Balbi wrote:

>>> I wonder how noone has noticed that from -rc1 until now.

>>     I don't think many people run the most current DaVinci kernel.
>> Most people probably use the Arago project kernels or even older
>> MV-based TI's stuff...

> that's nasty :-p All those hacks on a 2.6.18 kernel...

    If not 2.6.10... :-)

> Oh well, thanks for noticing and sending a patch :-)

    I have noticed that back when testing your patch series, if you remember. 
And I really should have fixed it earlier, so that it could get into 2.6.38 
(damn my illness that caused a week delay). BTW, you haven't done anything 
about the broken MUSB modules, have you?

WBR, Sergei
