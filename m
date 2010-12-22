From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 22 Dec 2010 11:17:59 +0100
Subject: [PATCH v2] i.MX51 Framebuffer support
In-Reply-To: <87bp4eb5r5.fsf@lechat.rtp-net.org> (Arnaud Patard's message of
	"Wed, 22 Dec 2010 08:56:14 +0100")
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<87bp4eb5r5.fsf@lechat.rtp-net.org>
Message-ID: <87ipymun54.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnaud" == Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:

 Arnaud> Sascha Hauer <s.hauer@pengutronix.de> writes:
 Arnaud> Hi,

 >> The following series adds i.MX51 framebuffer support based on the
 >> IPUv3. It is not perfect but I decided it is good enough to open it
 >> for a wider audience and collect first reviews. I tested this on a
 >> babbage board using both outputs (VGA/DVI) with different
 >> resolutions up to 1680x1050 and different colour depths.  I also
 >> tested it on one custom board using a fixed display setting.

 Arnaud> After adding code to my efika sb machine file and your patchset, I've
 Arnaud> seen the light. Err, no. It was a penguin and a login prompt.  I guess
 Arnaud> it means your patchset is working here.

Cool. Care to submit that machine file support?

-- 
Bye, Peter Korsgaard
