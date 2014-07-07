From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 7 Jul 2014 20:42:39 +0200
Subject: [PATCH 09/18] AT91: Call at91_register_devices in the board files
In-Reply-To: <20140703145222.GE31996@lukather>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404396906-25194-15-git-send-email-maxime.ripard@free-electrons.com>
 <D103F102-4B04-4CC6-8F20-58CEB0EC8E36@jcrosoft.com>
 <20140703145222.GE31996@lukather>
Message-ID: <20140707184239.GI9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:52 Thu 03 Jul     , Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jul 03, 2014 at 10:29:58PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > no do this at SoC level
> 
> Since it has to be done at init_machine, I don't see any other easy
> way to do this at the SoC level.
> 
> What is your suggestion?

do it earlier as there is not driver it will not change anything
