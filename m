From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 14 Oct 2010 17:28:12 +0200
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <alpine.LFD.2.00.1010131602590.2764@xanadu.home>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<alpine.LFD.2.00.1010131602590.2764@xanadu.home>
Message-ID: <AANLkTikex9BvozcfY8EDJ0EHepKR+gSOEyYyppZVCLx_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 10:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> It could, but then there has to be extra code in the resume handler to
> cope with the fact that the card was powered off.

Good point.

It's much better the way it is now.

Thanks,
Ohad.
