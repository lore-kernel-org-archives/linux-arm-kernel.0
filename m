From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 7 Nov 2016 01:32:29 +0000
Subject: [PATCH 1/2] ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
In-Reply-To: <20161105083145.GF5597@dragon>
References: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
 <20161105083145.GF5597@dragon>
Message-ID: <VI1PR04MB14556348390F18AF8D5A261D8BA70@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>On Mon, Oct 31, 2016 at 10:58:28AM +0800, Peter Chen wrote:
>> We need to change trimming value (as a percentage) of the 17.78mA TX
>> reference current for better signal quality. With this change, we can
>> patch the eye-diagram test on this board.
>
>s/patch/pass?  I just want to confirm this is a typo, and can fix it up when applying.
>

Thanks, Shawn. It is a typo. Help me to change both of patches please.

Peter
