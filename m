From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 May 2012 15:48:56 +0400
Subject: [PATCH] ARM: BCMRING: Fix UART declaration and clk dev name
 mismatch
In-Reply-To: <4FA03D05.9060303@broadcom.com>
References: <4FA03D05.9060303@broadcom.com>
Message-ID: <4FA11F28.4000704@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-05-2012 23:44, Jiandong Zheng wrote:

> Fix bcmring UART declaration and clk dev name mismatch

> In 888073d41680e8244232f3d850e0424a4e9de60f,

    Please also specify that commit's summary in parens.

> bcmring UART declaration
> was fixed but introduced clk dev name mismatch which leads to UART initialization
> failure during boot.

> Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>

WBR, Sergei
