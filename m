From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Oct 2015 01:58:02 +0000
Subject: [PATCH] ARM: dts: uniphier: add system-bus-controller nodes
In-Reply-To: <1445916065-13118-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445916065-13118-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151031015802.GG1722@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 12:21:05PM +0900, Masahiro Yamada wrote:
> The System Bus Controller block has two register regions,
> but having only the second one in a separate node was not nice.
> 
> Replace it with a new node with two register regions in it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied even though it's very late.

Based on the contents in the DT, the chips seem to share several identical
blocks at the same addresses. It could be worth trying to consolidate some
of the DT contents in a shared dtsi that contains these blocks.


-Olof
