From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 16:10:14 +0000
Subject: [PATCH 0/7] Introducing a generic AMP framework
In-Reply-To: <CAK=WgbYyrbZLmDOx8yKWwjhn2MYN8669FDRvsYZSyLj1equcTw@mail.gmail.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <4ECC67B9.4050306@codeaurora.org>
 <CAK=WgbYyrbZLmDOx8yKWwjhn2MYN8669FDRvsYZSyLj1equcTw@mail.gmail.com>
Message-ID: <20111123161012.GA31423@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 12:27:31PM +0200, Ohad Ben-Cohen wrote:
> On Wed, Nov 23, 2011 at 5:25 AM, Saravana Kannan <skannan@codeaurora.org> wrote:

> > Sorry for the rant, this naming just rubs me the wrong way. I definitely
> > appreciate the idea behind these patches.

> I don't share the same naming concerns you have (if any, then
> confusion with the bluetooth AMP patches and prefixes is more of a
> concern to me), but I don't care deeply about names.

I guess one very real potential for confusion here is the big/little
stuff that ARM are pushing for next generation SoCs where a Linux image
does actually run on muliple asymmetric cores.

> Feel free to offer a different name, though really 'amp' here only
> describes the general model and motivation and is rarely used
> throughout the code; we mostly either use 'remoteproc' or 'rpmsg',
> which respectively refer to the two frameworks that are being added
> (the former responsible for controlling the state of the remote
> processors, and the latter for communicating with them).

How about using remoteproc then?
