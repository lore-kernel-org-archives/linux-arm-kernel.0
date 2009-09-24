From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 24 Sep 2009 17:48:44 +0200
Subject: patches for pxafb
In-Reply-To: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
References: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
Message-ID: <20090924154844.GK9361@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 04:15:54PM +0200, Christopher Friedt wrote:
> I have a couple of patches for the pxa framebuffer that I would like
> to submit upstream,
> but I'm fairly new to it and thought that this would be a good place to start.

Yes, it is. The first things to read are Documentation/SubmittingPatches
and Documentation/CodingStyle. Then, use scripts/checkpatch.pl to verify
your patches.

> Also, I wrote a multi-function driver for the STMPE2401 gpio expander
> / keypad controller / rotator input / pwm output  chip, and would
> really appreciate it if someone could review it. I already informed
> another project (PeekLinux) via IRC, because their device uses the
> same chip, but had no replies. The code currently only impliments
> keypad functionality, but I've made lots of room / structure for the
> rest of the multi-function devices. I'd like to submit that upstream
> at some point after a couple of reviews. Any volounteers? :-)

The appropriate place to get feedback to such a driver are the linux-i2c
and linux-input mailing lists.

Daniel
