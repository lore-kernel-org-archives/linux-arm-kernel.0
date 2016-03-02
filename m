From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 2 Mar 2016 16:52:31 -0600
Subject: [PATCH net-next V2 04/16] net: fec: reduce interrupts
In-Reply-To: <56D769F0.9070901@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-5-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18558A7D0A57FA8EDBAD5EABFFBC0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
 <56D710EB.5000201@boundarydevices.com>
 <CAHrpEqQkuH1JQfKFa=S+ZqbnHpR_SdihM3_dJ++nokV1tczM_Q@mail.gmail.com>
 <56D769F0.9070901@boundarydevices.com>
Message-ID: <CAHrpEqRgmdjF-5ZHJVx=NRH-g_HbkLa2QxYM+yoN=rOqDT6jmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 4:32 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> FEC_ENET_TS_TIMER

I think so. TS_TIMER should never be triggered.

best regards
Frank Li
