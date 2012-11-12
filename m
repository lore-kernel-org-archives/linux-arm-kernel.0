From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Nov 2012 10:39:20 +0100
Subject: [PATCH RFT 1/2] pinctrl: dove: Fix dove_audio1_ctrl_set when
 BIT(0|1|2|3) of config is clear
In-Reply-To: <1352641495.3113.1.camel@phoenix>
References: <1352641495.3113.1.camel@phoenix>
Message-ID: <50A0C3C8.2020501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 02:44 PM, Axel Lin wrote:
> Current implementation in dove_audio1_ctrl_set() does not clear corresponding
> register bit if BIT(0|1|2|3) of config is clear. Fix it.
>
> Signed-off-by: Axel Lin<axel.lin@ingics.com>

Axel,

thanks for the hint on not clearing the audio1 bits before setting them.
I will test this tonight and guess you should prepare a real patch for
this one.

Sebastian
