From: olof@lixom.net (Olof Johansson)
Date: Thu, 23 Jan 2014 18:05:51 -0800
Subject: [PATCH] ARM: moxart: move fixed rate clock child node to board
 level dts
In-Reply-To: <1389886746-972-1-git-send-email-jonas.jensen@gmail.com>
References: <1389886746-972-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140124020551.GA17877@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 04:39:06PM +0100, Jonas Jensen wrote:
> When a skeleton "clocks { .. }" remain in .dtsi, the child node can
> be moved to .dts, "ref12" is then found by of_clk_get().
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied to late/misc branch, will likely be included in 3.14-rc1


-Olof
