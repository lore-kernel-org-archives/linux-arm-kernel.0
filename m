From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Feb 2017 12:46:43 -0600
Subject: [PATCH] dt-bindings: net: remove reference to fixed link support
In-Reply-To: <20170203.155938.1981764313840579677.davem@davemloft.net>
References: <1486054064-31093-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170203.155938.1981764313840579677.davem@davemloft.net>
Message-ID: <20170207184643.janfd47zureahrc4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 03:59:38PM -0500, David Miller wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date: Thu,  2 Feb 2017 17:47:44 +0100
> 
> > Contrary to what the Device Tree binding indicates, the binding for the
> > PPv2 network device currently doesn't provide any fixed link
> > functionality. This commit adjusts the Device Tree binding documentation
> > accordingly.
> > 
> > Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> What tree is this intended to go into?  Mine?

I've applied to DT tree.

Rob
