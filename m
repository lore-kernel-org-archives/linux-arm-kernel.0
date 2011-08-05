From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 05 Aug 2011 15:04:49 +0400
Subject: [patch 1/1] iMX: Fix build for iMX53
In-Reply-To: <20110805073253.599604130@rtp-net.org>
References: <20110805073240.162681115@rtp-net.org>
	<20110805073253.599604130@rtp-net.org>
Message-ID: <4E3BCE51.9010405@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-08-2011 11:32, Arnaud Patard (Rtp) wrote:

> Commit fad107086d5a869c1c07e5bb35b7b57a10ecf578 fixed the wrong test for MX51

    Please specify that commit's summary in parens.

> as the MX51 addresses are wrong for MX50 and MX53 but now it's MX51 only,
> UART_PADDR is not defined anymore when building for MX50/MX53.

> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Tested-by: Steev Klimaszewski <steev@genesi-usa.com>

WBR, Sergei
