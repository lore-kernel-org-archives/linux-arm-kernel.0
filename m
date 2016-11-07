From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 7 Nov 2016 10:06:08 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
In-Reply-To: <VI1PR04MB14556348390F18AF8D5A261D8BA70@VI1PR04MB1455.eurprd04.prod.outlook.com>
References: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
 <20161105083145.GF5597@dragon>
 <VI1PR04MB14556348390F18AF8D5A261D8BA70@VI1PR04MB1455.eurprd04.prod.outlook.com>
Message-ID: <20161107020607.GC14622@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 01:32:29AM +0000, Peter Chen wrote:
>  
> >On Mon, Oct 31, 2016 at 10:58:28AM +0800, Peter Chen wrote:
> >> We need to change trimming value (as a percentage) of the 17.78mA TX
> >> reference current for better signal quality. With this change, we can
> >> patch the eye-diagram test on this board.
> >
> >s/patch/pass?  I just want to confirm this is a typo, and can fix it up when applying.
> >
> 
> Thanks, Shawn. It is a typo. Help me to change both of patches please.

Applied both, thanks.
