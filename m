From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 27 May 2015 11:25:49 +0200
Subject: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
In-Reply-To: <20150527091902.GN3199@piout.net>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
 <1432713024.27695.235.camel@x220> <20150527091902.GN3199@piout.net>
Message-ID: <1432718749.27695.254.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-27 at 11:19 +0200, Alexandre Belloni wrote:
> However, the Kconfig maintainer found a way to do the right thing so we
> may as well drop that patch and keep those as modules.

Perhaps I missed a message: do you have a link?

(I fiddled a bit with the build setup of these drivers too, but then
noticed that the patch was already applied, and abandoned that.)

Thanks,


Paul Bolle
