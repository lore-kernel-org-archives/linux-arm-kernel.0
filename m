From: davem@davemloft.net (David Miller)
Date: Mon, 19 Nov 2012 14:01:02 -0500 (EST)
Subject: [PATCH 3/3] net: mvneta: adjust multiline comments to net/ style
In-Reply-To: <50AA2AD4.6030007@mvista.com>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353322834-16952-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <50AA2AD4.6030007@mvista.com>
Message-ID: <20121119.140102.642494594218015592.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Mon, 19 Nov 2012 16:49:24 +0400

>    Why the heck you're doing this? It's the preferred style, see
>    Documentation/CodingStyle, chapter 8.

Not in the networking code, we prefer:

	/* Doing it,
	 * like this.
	 */

there.
