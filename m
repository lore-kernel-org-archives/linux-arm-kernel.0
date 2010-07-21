From: qy03fugy@stud.informatik.uni-erlangen.de (Christian Dietrich)
Date: Wed, 21 Jul 2010 15:52:29 +0200
Subject: drivers/scsi/arm/acornsci.c -- Dead CONFIG_* options
Message-ID: <86d3uhhrhe.fsf@peer.zerties.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!
       
        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

I also encountered some reference problems in
drivers/scsi/arm/acornscsi.c. But they seem to be intentionally, in
order to make integration into the linux kernel working. But the last
changelog entry is from 1998. So perhaps some of this ifdefs can be
removed. If this should be done i can make up a patch and send it.

[0] http://vamos1.informatik.uni-erlangen.de
-- 
(? x . x x) (? x . x x) -- See how beatiful the lambda is
No documentation is better than bad documentation
-- Das Ausdrucken dieser Mail wird urheberrechtlich verfolgt.
