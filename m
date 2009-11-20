From: greg@kroah.com (Greg KH)
Date: Thu, 19 Nov 2009 21:36:07 -0800
Subject: [REPOST PATCH 1/3] MXC: Add i.MX21 specific USB host
	controller driver.
In-Reply-To: <ba4215e10911180142w204b8e85mc8b55bc329d54ffb@mail.gmail.com>
References: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
	<20091108185222.14742.11572.stgit@srv002.fuzzey.net>
	<20091110051603.GA27314@kroah.com>
	<ba4215e10911180142w204b8e85mc8b55bc329d54ffb@mail.gmail.com>
Message-ID: <20091120053607.GA19446@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 10:42:42AM +0100, Martin Fuzzey wrote:
> On Tue, Nov 10, 2009 at 6:16 AM, Greg KH <greg@kroah.com> wrote:
> > I didn't notice anything objectionable here, but host controller drivers
> > are not my speciality. ?If it's working for you, that is a good reason
> > to get it in for wider testing.
> >
> 
> Yes it's working fine for me.
> 
> There have been no other comments on the driver part - do I need to do
> anything else to get it in?
> 
> If it's ok to repost just the platform resource bits with the couple
> of mods requested (spelling mistake and letting compiler count array
> indices) I'll just do that - seems stupid to repost the unmodified
> driver.

Please repost the whole thing, I don't have it in my queue anymore.

thanks,

greg k-h
