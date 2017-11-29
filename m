From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Nov 2017 10:56:07 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77970: use SYSC power domain
 macros
In-Reply-To: <20171128202109.031715810@cogentembedded.com>
References: <20171128202109.031715810@cogentembedded.com>
Message-ID: <20171129095607.x33pokvib4csba73@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 11:15:45PM +0300, Sergei Shtylyov wrote:
> Now that the commit 833bdb47c826 ("dt-bindings: power: add R8A77970 SYSC
> power domain definitions") has hit Linus' tree, we can replace the  bare
> numbers  (we had to use to avoid a cross tree dependency) with these macro
> definitions...

Thanks, applied.
