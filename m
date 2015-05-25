From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 25 May 2015 15:02:27 +0200
Subject: [PATCHv2] ARM: mvebu: add support for the new Aramda 385 based
 Linksys boards
In-Reply-To: <55631C6E.8050700@free-electrons.com>
References: <1432156456-440-1-git-send-email-kaloz@openwrt.org>
 <55631C6E.8050700@free-electrons.com>
Message-ID: <op.xy6zudje2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mon, 25 May 2015 14:58:22 +0200, Gregory CLEMENT  
<gregory.clement@free-electrons.com> wrote:

<snip>

> it seems that you missed my comment about removing bootargs and just  
> using
> stdout-path = "serial0:115200n8";
>
> If you agree and if there is no remark about the DSA part from Andrew, I  
> can
> take car of it while applying your patch on mvebu/dt.

Sorry, I indeed did miss it. I agree with that change. Andrew?


Thanks,

Imre
