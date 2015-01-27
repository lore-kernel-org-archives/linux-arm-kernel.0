From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Jan 2015 14:53:24 -0800
Subject: [PATCH] ARM: pxa: fix broken isa interrupts for zeus and viper
In-Reply-To: <1422338110-12070-1-git-send-email-robert.jarzmik@free.fr>
References: <1422338110-12070-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150127225324.GA11019@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:55:10AM +0100, Robert Jarzmik wrote:
> Commit "ARM: pxa: arbitrarily set first interrupt number" broke viper
> and zeus boards which still refer to PXA_ISA_IRQ() macro. Redefine
> the macro, which declares the legacy interrupts from 0 to 15.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>


Applied. Thanks.


-Olof
