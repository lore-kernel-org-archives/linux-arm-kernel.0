From: xerofoify@gmail.com (Nick Krause)
Date: Sun, 13 Jul 2014 17:06:20 -0400
Subject: Fix Me in file gpmc-onenand.c
Message-ID: <CAPDOMVhMeqHzRsae-TqeNsO2hQF9gE9au9y2oMPohVHOXrs70A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Kevin,
I am using cscope to find fix mes in the latest git kernels that still
need cleanup. Furthermore  I seem to hitting one in a that file that
you maintain.
Due to this I am wondering should I remove this code or does it still
need to be in the mainline kernel and what mach-omap2 cpus does it
check for.
to support with this if statement.  I am pasting the FiXME and the
code that code around it.
Cheers Nick
else {
               /*
                * FIXME: Appears to be legacy code from initial ONENAND commit.
                 * Unclear what boards this is for and if this can be removed.
                 */
               if (!cpu_is_omap34xx())
                       onenand_sync.wait_on_read = true;
         }
