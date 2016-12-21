From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Dec 2016 18:02:52 +0100
Subject: [PATCH net-next 14/27] net: mvpp2: add ip_version field in
 "struct mvpp2"
In-Reply-To: <1482318994-23488-15-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482318994-23488-15-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20161221170252.GO30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

Minor nit pick.

On Wed, Dec 21, 2016 at 12:16:21PM +0100, Thomas Petazzoni wrote:
> In preparation to the introduction for the support of PPv2.2 in the
> mvpp2 driver, this commit adds an ip_version field to the struct
> mvpp2

When i read this, i was thinking IPv4 vs IPv6. It is a network driver after all.
Could you maybe call this hw_version?

Thanks
	Andrew
