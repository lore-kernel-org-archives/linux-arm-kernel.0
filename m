From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 15 Jan 2017 13:17:11 +0300
Subject: [PATCH net-next v3 04/10] net: dsa: Move ports assignment closer
 to error checking
In-Reply-To: <20170114214713.28109-5-f.fainelli@gmail.com>
References: <20170114214713.28109-1-f.fainelli@gmail.com>
 <20170114214713.28109-5-f.fainelli@gmail.com>
Message-ID: <f67f9157-47fb-bb55-a248-de63b6d9d851@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 1/15/2017 12:47 AM, Florian Fainelli wrote:

> Move the assignment of ports in _dsa_register_switch() closer to where
> it is checked, no functional change. Re-order declarations to be

    "Be" not needed.

> preserve the inverted christmas tree style.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
[...]

MBR, Sergei
