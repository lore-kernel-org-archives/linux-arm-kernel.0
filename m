From: yocto6@gmail.com (nick)
Date: Sat, 27 Sep 2014 22:37:02 -0400
Subject: Legacy Code in gpmc-onenand.c
Message-ID: <5427744E.4040409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings Kevin and others,
I am wondering if the below code is legacy I can remove it as stated it the fix me.
Cheers Nick 
else {
                /*
                * FIX ME: Appears to be legacy code from initial ONENAND commit.
                * Unclear what boards this is for and if this can be removed.
                 */
                if (!cpu_is_omap34xx())
                        onenand_sync.wait_on_read = true;
        }
