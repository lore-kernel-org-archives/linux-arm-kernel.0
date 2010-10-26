From: arasv@magellan-technology.com (Aras Vaichas)
Date: Tue, 26 Oct 2010 17:19:30 +1100
Subject: at91: input overruns question
Message-ID: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm updating our production kernel to 2.6.33.7-rt29 for an at91rm9200.
This is the newest version supported by RT.

I've noticed that the age-old debug serial input overrun(s) issue has
gotten far worse and I can no longer use the cursor keys at all. i.e.
no history on serial console or vi.

As the kernel version numbers have gone up, the problem seems to have
gotten worse.

Is there anything that I can do to make it a bit more usable?

Any .config changes?

Is it worse because of the RT patches?

Please feel free to point me to any previous posts discussing the
issue, or solutions.

Thanks!

-- 
Aras Vaichas

Senior Engineer - Software?|?Magellan Technology Pty Ltd

65 Johnston St, Annandale NSW 2038, Australia

P | +61 2 9562 9854 | F +61 2 9518 7620 |??arasv at magellan-technology.com
