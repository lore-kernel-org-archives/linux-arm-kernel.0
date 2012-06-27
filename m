From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Jun 2012 14:51:50 -0600 (MDT)
Subject: [PATCH v2] arm: omap3: am35x: Set proper powerdomain states
In-Reply-To: <1337109255-14704-1-git-send-email-mgreer@animalcreek.com>
References: <1337109255-14704-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1206271451180.27496@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs only support the PWRSTS_ON
> state so create a new set of powerdomain structures
> that ensure that only the ON state is entered.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Thanks, queued for 3.6.


- Paul
