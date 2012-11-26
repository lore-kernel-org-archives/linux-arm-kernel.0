From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Nov 2012 10:40:27 +0000
Subject: [question] some question about the residue
In-Reply-To: <50B34668.1090402@atmel.com>
References: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
 <1353912597.7077.67.camel@vkoul-udesk3> <50B31BCE.6020100@atmel.com>
 <20121126102200.GB19440@n2100.arm.linux.org.uk> <50B34668.1090402@atmel.com>
Message-ID: <20121126104027.GD19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 06:37:28PM +0800, Elen Song wrote:
> So residue actually means current active descriptor remain, it should  

No, not the current active descriptor - the transfer identified by the
cookie, and only that transfer.
