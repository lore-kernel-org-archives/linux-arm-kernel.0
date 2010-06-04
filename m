From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 04 Jun 2010 11:48:54 +0200
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100604085320.GB25357@pengutronix.de>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100604085320.GB25357@pengutronix.de>
Message-ID: <1275644934.3210.46.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-06-04 at 10:53 +0200, Sascha Hauer wrote:
> I'm not willing to accept another 3ds_debug board support in the
> kernel
> given that it's no rocket science to seperate this into another file
> and
> we still have plenty of time before the next merge window.
> Jason, can you please move this to plat-mxc? I think we could find
> someone else to switch the mx31_3ds support to the generic debug board
> support then. 

Sascha, what do you mean with: switch the mx31_3ds support to the generic
one in plat-mxc?
We are going to have a single machine file for all imx(2-3-5) based debug boards?
I think it will look so messy..

I read the Linus concerns about ARM stuffs and RMK answer to your ask for pull..
May we need to start a thread to discuss how we can restructure the imx support?

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
