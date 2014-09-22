From: johan@kernel.org (Johan Hovold)
Date: Mon, 22 Sep 2014 17:18:54 +0200
Subject: [PATCH v5 5/9] rtc: at91sam9: make use of syscon/regmap to
 access GPBR registers
In-Reply-To: <1411377058-26155-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1411377058-26155-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411377058-26155-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140922151854.GI5237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 11:10:54AM +0200, Boris BREZILLON wrote:
> The GPBR registers are not part of the RTT block and thus should not be
> defined in the reg property of the rtt node.
> 
> Use syscon to provide a proper DT representation and reference the GPBR
> syscon device in a new "atmel,time-reg" property which store both the

You forgot to update the commit message with the new property name.

Johan
