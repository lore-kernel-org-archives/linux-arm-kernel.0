From: mgreer@animalcreek.com (Mark A. Greer)
Date: Mon, 14 May 2012 11:15:46 -0700
Subject: [PATCH] arm: omap3: am35x: Set proper powerdomain states
In-Reply-To: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
References: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <20120514181546.GA29952@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 02:26:48PM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs only support the PWRSTS_ON
> state so create a new set of powerdomain structures
> that ensure that only the ON state is entered.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---

Ping?
