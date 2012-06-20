From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 20 Jun 2012 15:56:58 +0400
Subject: [PATCH] ARM: Orion5x - Restore parts of io.h
In-Reply-To: <1340172410-11229-1-git-send-email-andrew@lunn.ch>
References: <1340172410-11229-1-git-send-email-andrew@lunn.ch>
Message-ID: <4FE1BA8A.8070908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-06-2012 10:06, Andrew Lunn wrote:

> Commit 4d5fc58dbe34b78157c05b319669bb3e064ba8bd

    Please also specify that commit's summary in parens.

> remove the orion5x
> io.h. Unfortunetely, this is still needed for the definition of
> IO_SPACE_LIMIT which overrides the default 64K. All Orion based
> systems have 1Mbyte of IO space per PCI[e] bus, and try to
> request_resource() this size.

> Signed-off-by: Andrew Lunn<andrew@lunn.ch>

WBR, Sergei
