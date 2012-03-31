From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 01 Apr 2012 01:44:32 +0400
Subject: [PATCH V2 4/4] Input: pxa27x_keypad add choice to set
 direct_key_mask
In-Reply-To: <1333072698-15344-4-git-send-email-chao.xie@marvell.com>
References: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
 <1333072698-15344-4-git-send-email-chao.xie@marvell.com>
Message-ID: <4F777AC0.8040304@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-03-2012 5:58, Chao Xie wrote:

> Direct keys usage may not start from KP_DKIN0, add a msk option
> to configure the specifics for platforms that can skip some keys.

> Change-Id: Ia8fd28254fec9595dcf39f12a78392c1e8b675eb

    Remove this line please -- it has no place in upstream patch.

> Signed-off-by: Chao Xie <chao.xie@marvell.com>

WBR, Sergei
