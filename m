From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 27 Jan 2015 15:13:50 +0100
Subject: [PATCHv2] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <20150126184436.GE5015@lunn.ch>
References: <1421687701-5667-1-git-send-email-kaloz@openwrt.org>
 <20150126184436.GE5015@lunn.ch>
Message-ID: <op.xs4khcpz2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, 26 Jan 2015 19:44:36 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

>> +	model = "Linksys WRT1900AC (Mamba)";
>> +	compatible = "linksys,mamba", "marvell,armadaxp-mv78230",
>> +		     "marvell,armadaxp", "marvell,armada-370-xp";
>
> Hi Imre
>
> So the consensus seems to be
>
>  model = "Linksys WRT1900AC";
>  compatible = "linksys,mamba", "...";
>
> with leds using mamba.

Okie.

> Please name the file armada-xp-linksys-mamba.dts.

Will do, thanks everyone for the help.


Imre
