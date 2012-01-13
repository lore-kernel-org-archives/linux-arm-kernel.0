From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 13 Jan 2012 18:52:02 +0300
Subject: [PATCH] ARM: mach-davinci: removed un-existing pll1_sysclk4-7
 clock domains
In-Reply-To: <20120113124811.GA9223@altenpts-laptop>
References: <20120113124811.GA9223@altenpts-laptop>
Message-ID: <4F105322.3030206@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/13/2012 03:48 PM, Bas van den Berg wrote:

> sysclk4-7 only exist for pll0. for pll1 sysclk1-3 exist.

    You should have marked (in the subject and here) that you're doing this for 
DA850 only.

> Signed-off-by: Bas van den Berg<b.van.den.berg.nl@gmail.com>

WBR, Sergei
