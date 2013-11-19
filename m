From: zql@glomationinc.com (Zhong Li)
Date: Tue, 19 Nov 2013 13:09:26 -0500
Subject: [alsa-devel] Bug? Sound support for at91sam9x5-wm8731 based boards
In-Reply-To: <CACQ1gAgykmgPKY4SHujnNtm4Sr=wt5knLkQL-MRS_pC73bOi4Q@mail.gmail.com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
 <1384878685-1515-3-git-send-email-tony@atomide.com>
 <031f01cee547$950b5670$bf220350$@com>
 <CACQ1gAgykmgPKY4SHujnNtm4Sr=wt5knLkQL-MRS_pC73bOi4Q@mail.gmail.com>
Message-ID: <033601cee552$7c2c2570$74847050$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can you give a little more background ? :
> - What kernel ?
> - Command line to reproduce ?
> 
> Richard.

One of the testing hardware is the Atmel at91sam9g25-ek (the CPU module and the carrier board).  We tried both the 2.6.39 patched with the Atmel patches and the mainline 3.12-rc.  The command to test the sound is just the simple aplay <sound-test-file>.  The wav file is available here, https://drive.google.com/file/d/0B3TSFX4Mq9PoeTdJOGVaZk5rTWM/edit?usp=sharing.

Thanks
