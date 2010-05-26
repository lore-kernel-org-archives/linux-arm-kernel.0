From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 25 May 2010 21:21:52 -0400 (EDT)
Subject: [PATCH] Kirkwood: Fix explanation of MPP45 for QNAP TS41x
Message-ID: <alpine.LFD.2.00.1005252114100.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 May 2010, Martin Michlmayr wrote:

> On the QNAP TS-41x, MPP45 is used to show the setting of jumper JP1.
> Fix the documentation to explain what the settings really indicate.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

I've applied your one-liners to the orion.git repo on git.kernel.org.  I 
should push them toward mainline after -rc1 is out.


Nicolas
