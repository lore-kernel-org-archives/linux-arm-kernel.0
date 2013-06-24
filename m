From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Jun 2013 17:18:14 -0600
Subject: [PATCH v1 07/12] input: keypad-matrix: introduce polling support
In-Reply-To: <20130622095022.GG24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-8-git-send-email-gsi@denx.de>
 <51C4C7C3.1070905@wwwdotorg.org>
 <20130622095022.GG24305@book.gsilab.sittig.org>
Message-ID: <51C8D3B6.3090108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2013 03:50 AM, Gerhard Sittig wrote:

...
> The patch set doesn't introduce that behaviour, but merely
> describes it in more detail.  It doesn't even introduce the
> interrupt discussion into the binding document in a strict sense,
> but expands on it in the hope for improved usability of the
> binding after the motivation became more obvious.
> 
> 
> What this part of the series does is to introduce polling mode as
> an alternative to the interrupt driven detection of changes, to
> improve reliability of change detection in the presence of multi
> key presses.

To me, this sounds more like something for Documentation/input/ rather
than DT binding.

...
> I suggest to have the "meta-discussions" on which documentation
> belongs where and on where to put the GPIO polarity and on
> whether backward compatibility needs to be kept or may be broken,
> in a single spot, to not have several parallel discussions in
> multiple subthreads.
> 
> Is the cover letter or the first patch the most appropriate
> message to respond to with this though in mind?  Or don't you
> mind if several replies for different parts of the patch set
> discuss similar "background" aspects of the same series?

I don't really have a preference myself; feel free to pick whichever
patch or response you want to continue discussing, and reply to that;
I'll just reply to whatever sub-thread/... you choose:-)
