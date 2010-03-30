From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Mar 2010 21:40:21 +0100
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <4BB22576.1070108@epfl.ch>
References: <4BB22576.1070108@epfl.ch>
Message-ID: <20100330204021.GA4666@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 30, 2010 at 06:23:18PM +0200, Valentin Longchamp wrote:

> I have quickly hacked something based on what you had done for
> pcm037 with the MC13783 codec in some of your first sound patches. I
> know that this is not ready for mainline and I'm still struggling to
> debug my code, but I would like to have results quite soon so that
> my colleague could see what sounds (especially regarding to the
> volume) our system is capable to produce.

If you're struggling to find time to do full support for the CODEC a
good technique is often to get just very basic fixed function support
(say just DAC to headphone support) implemented and merged, then go back
and implement

I'd also suggest looking at the current Freescale BSPs - obviously this
device is used on a lot of Freescale reference boards and I believe
there's a reasonably mainlineish driver in the BSPs they have for
current devices.
