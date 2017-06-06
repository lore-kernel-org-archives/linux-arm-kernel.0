From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 6 Jun 2017 18:44:30 +0300
Subject: [PATCH] net: mvpp2: do not bypass the mvpp22_port_mii_set function
In-Reply-To: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
References: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
Message-ID: <942ac798-e6f1-ce68-3651-c01c2e5ed60b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 06/06/2017 04:36 PM, Antoine Tenart wrote:

> The mvpp22_port_mii_set() function was added by 2697582144dd, but the

    Need to also specify the commit summary line enclosed in ("").

> function directly returns without doing anything. This return was used
> when debugging and wasn't removed before sending the patch. Fix this.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
[...]

MBR, Sergei
