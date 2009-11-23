From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 23 Nov 2009 21:32:04 +0100
Subject: spitz: suspend/resume broken in pxa tree
Message-ID: <20091123203204.GA26942@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I tried checking out Eric's pxa tree (I hope I got it right), and 

commit b0bd7b56ff4a0672d11751e4f20505d1cad1e132
Merge: 989eadd 0352170
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Wed Nov 11 22:51:19 2009 +0800

    Merge branch 'topic/cm-x300' into for-next
    
    Conflicts:
        arch/arm/mach-pxa/cm-x300.c

(which should be current head?) seems to boot ok, but there's no
reaction on power button after suspend :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
