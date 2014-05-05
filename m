From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 May 2014 21:55:29 -0700
Subject: [PATCH 1/3] ARM: mvebu: clean-up unneeded kconfig selects
In-Reply-To: <1398195678-28787-2-git-send-email-robherring2@gmail.com>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
 <1398195678-28787-2-git-send-email-robherring2@gmail.com>
Message-ID: <20140505045529.GA16022@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 02:41:16PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Multi-platform support implies all these options are already selected and
> individual platforms don't need to select them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

What's this based on? It doesn't apply to 3.15-rc4.


-Olof
